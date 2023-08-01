Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B0F876BB74
	for <lists+qemu-devel@lfdr.de>; Tue,  1 Aug 2023 19:39:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQtJg-0006Jy-1K; Tue, 01 Aug 2023 13:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qQtJc-0006Fx-A7; Tue, 01 Aug 2023 13:37:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qQtJa-0002HZ-Jc; Tue, 01 Aug 2023 13:37:48 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E0278174EC;
 Tue,  1 Aug 2023 20:37:46 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D6E261A9BC;
 Tue,  1 Aug 2023 20:37:31 +0300 (MSK)
Message-ID: <a77ece2f-34ea-6af3-9b36-410ec511eaee@tls.msk.ru>
Date: Tue, 1 Aug 2023 20:37:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v2] io: remove io watch if TLS channel is closed during
 handshake
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 qemu-stable@nongnu.org, Mauro Matteo Cascella <mcascell@redhat.com>,
 jiangyegen <jiangyegen@huawei.com>
References: <20230712165547.584157-1-berrange@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230712165547.584157-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.092,
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

12.07.2023 19:55, Daniel P. Berrangé wrote:
> The TLS handshake make take some time to complete, during which time an
> I/O watch might be registered with the main loop. If the owner of the
> I/O channel invokes qio_channel_close() while the handshake is waiting
> to continue the I/O watch must be removed. Failing to remove it will
> later trigger the completion callback which the owner is not expecting
> to receive. In the case of the VNC server, this results in a SEGV as
> vnc_disconnect_start() tries to shutdown a client connection that is
> already gone / NULL.
> 
> CVE-2023-3354
> Reported-by: jiangyegen <jiangyegen@huawei.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Can we have this in 8.1 please?

What's needed to get this one into 8.1?

/mjt

