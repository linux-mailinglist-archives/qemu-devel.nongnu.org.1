Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E30799D61
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 10:42:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfFzm-0002sW-7P; Sun, 10 Sep 2023 04:40:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfFzg-0002rQ-Uh; Sun, 10 Sep 2023 04:40:36 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfFzd-0007KP-6i; Sun, 10 Sep 2023 04:40:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 5A08A2084A;
 Sun, 10 Sep 2023 11:41:19 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8429326F71;
 Sun, 10 Sep 2023 11:40:26 +0300 (MSK)
Message-ID: <38d13ff4-42ab-655a-00e8-51f977117d3c@tls.msk.ru>
Date: Sun, 10 Sep 2023 11:40:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH vOther2 1/1] qemu-nbd: Restore "qemu-nbd -v --fork" output
Content-Language: en-US
To: 20230825192940.35364-1-den@openvz.org, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org,
 "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, Mike Maslenkin <mike.maslenkin@gmail.com>
References: <20230825200838.39994-1-den@openvz.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230825200838.39994-1-den@openvz.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

25.08.2023 23:08, Denis V. Lunev wrote:
> +            /* Remember parent's stderr if we will be restoring it. */
> +            if (verbose /* fork_process is set */) {
> +                opts.stderr = dup(STDERR_FILENO);
> +                if (opts.stderr < 0) {
> +                    error_report("Could not dup stdedd: %s", strerror(errno));
> +                    exit(EXIT_FAILURE);
> +                }
> +            }
> +
>               ret = qemu_daemon(1, 0);

I haven't looked closely to this development.

To me it all looks.. backwards.

Instead of saving stderr around qemu_daemon() call, it might be more
productive to tell qemu_daemon() to stop redirecting stderr (and maybe
instrumenting it to do so).

Besides, qemu has 2 daemon implementations, one is qemu_daemon()
in util/oslib-posix.c and another is os_daemonize() in os-posix.c.
Note os_daemonize() does the right thing wrt logging already, -

         /* In case -D is given do not redirect stderr to /dev/null */
         if (!qemu_log_enabled()) {
             dup2(fd, 2);
         }

but I guess nbd does not use qemu_log_enabled() et al.

Also, qemu-nbd can benefit from using -runas/-chroot too.

Ideally this whole thing should be consolidated.  I already took a
step towards this by moving softmmu-specific stuff from os-posix.c
to softmmu/, this work should continue. When it's done, we can
revert this band-aid change for a real solution.

Thanks,

/mjt

