Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD39743F49
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 17:58:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFGUR-0000kg-Ks; Fri, 30 Jun 2023 11:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qFGUO-0000j1-Jz
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 11:56:52 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qFGUM-0006Qj-Ii
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 11:56:52 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D8B8410679;
 Fri, 30 Jun 2023 18:56:37 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C4A2A10D8E;
 Fri, 30 Jun 2023 18:56:36 +0300 (MSK)
Message-ID: <258917a6-62a3-8d5d-c651-4a11942801c4@tls.msk.ru>
Date: Fri, 30 Jun 2023 18:56:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] os-posix: Allow 'chroot' via '-run-with' and deprecate
 the old '-chroot' option
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: libvir-list@redhat.com, Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20230630150112.435874-1-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230630150112.435874-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.095,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

30.06.2023 18:01, Thomas Huth wrote:
> We recently introduced "-run-with" for options that influence the
> runtime behavior of QEMU. This option has the big advantage that it
> can group related options (so that it is easier for the users to spot
> them) and that the options become introspectable via QMP this way.
> So let's start moving more switches into this option group, starting
> with "-chroot" now.
...
> +static QemuOptsList qemu_run_with_opts = {
> +    .name = "run-with",
> +    .head = QTAILQ_HEAD_INITIALIZER(qemu_run_with_opts.head),
> +    .desc = {
> +#if defined(CONFIG_LINUX)
> +        {
> +            .name = "async-teardown",
> +            .type = QEMU_OPT_BOOL,
> +        },
> +#endif
> +        {
> +            .name = "chroot",
> +            .type = QEMU_OPT_STRING,
> +        },
> +        { /* end of list */ }
> +    },
> +};
> +
> +static void register_teardown(void)
> +{
> +    qemu_add_opts(&qemu_run_with_opts);
> +}
> +opts_init(register_teardown);

Hmm.. Is it still register_teardown? :)

Other than that,

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

/mjt

