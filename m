Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB29F7A9461
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 14:43:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjJ0H-0006C8-D0; Thu, 21 Sep 2023 08:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjIzD-0005Mc-0B
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:40:52 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qjIys-000105-HF
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 08:40:50 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B56081F37C;
 Thu, 21 Sep 2023 12:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695299374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJ0e+qBPi/70O3A+sITt5u+xBl4/+HTSZt8i74+vKa4=;
 b=U7fTNlVDqi1kVzF/vjmDod6KprmDFKKdL4qs6hwutfoHGppiOg5DENV1BhP/phz2Q6ibI9
 egakCa0JZDIS4gVZuXA3k1xf0C0ETcfIAlNzeGAe6OdhXU4xuAioohChMj1O248NzOOLHr
 yw4GXC7bg9mKjXrq5Fs5OUTX98QT7n4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695299374;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dJ0e+qBPi/70O3A+sITt5u+xBl4/+HTSZt8i74+vKa4=;
 b=Bn59DrpgXrfz8UD1zOKsYZu2kemBrHFKakK6VO8o7eMAGFeg1nyTchipfgLmL2Y0+nb0sh
 39DRBMQKxscWj8DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 42DCA134B0;
 Thu, 21 Sep 2023 12:29:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ptMQBC43DGULGgAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 21 Sep 2023 12:29:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, "quintela@redhat.com"
 <quintela@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "leobras@redhat.com" <leobras@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Zhijian Li (Fujitsu)"
 <lizhijian@fujitsu.com>
Subject: Re: [PATCH 2/2] migration/rdma: zore out head.repeat to make the
 error more clear
In-Reply-To: <2d876f0c-8726-81df-3a62-2d79a6b44ba8@fujitsu.com>
References: <20230920090412.726725-1-lizhijian@fujitsu.com>
 <20230920090412.726725-2-lizhijian@fujitsu.com> <87ttrpm20o.fsf@suse.de>
 <2d876f0c-8726-81df-3a62-2d79a6b44ba8@fujitsu.com>
Date: Thu, 21 Sep 2023 09:29:31 -0300
Message-ID: <871qervhec.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com> writes:

> On 20/09/2023 21:01, Fabiano Rosas wrote:
>> Li Zhijian <lizhijian@fujitsu.com> writes:
>> 
>>> From: Li Zhijian <lizhijian@cn.fujitsu.com>
>>>
>>> Previously, we got a confusion error that complains
>>> the RDMAControlHeader.repeat:
>>> qemu-system-x86_64: rdma: Too many requests in this message (3638950032).Bailing.
>>>
>>> Actually, it's caused by an unexpected RDMAControlHeader.type.
>>> After this patch, error will become:
>>> qemu-system-x86_64: Unknown control message QEMU FILE
>>>
>>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>>> ---
>>>   migration/rdma.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/migration/rdma.c b/migration/rdma.c
>>> index a2a3db35b1..3073d9953c 100644
>>> --- a/migration/rdma.c
>>> +++ b/migration/rdma.c
>>> @@ -2812,7 +2812,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
>>>           size_t remaining = iov[i].iov_len;
>>>           uint8_t * data = (void *)iov[i].iov_base;
>>>           while (remaining) {
>>> -            RDMAControlHeader head;
>>> +            RDMAControlHeader head = {};
>>>   
>>>               len = MIN(remaining, RDMA_SEND_INCREMENT);
>>>               remaining -= len;
>> 
>
> 2815             RDMAControlHeader head = {};
> 2816
> 2817             len = MIN(remaining, RDMA_SEND_INCREMENT);
> 2818             remaining -= len;
> 2819
> 2820             head.len = len;
> 2821             head.type = RDMA_CONTROL_QEMU_FILE;
> 2822
> 2823             ret = qemu_rdma_exchange_send(rdma, &head, data, NULL, NULL, NULL);
>
>> I'm struggling to see how head is used before we set the type a couple
>> of lines below. Could you expand on it?
>
>
> IIUC, head is used for both common migration control path and RDMA specific control path.
>
> hook_stage(RAM_SAVE_FLAG_HOOK) {
>     rdma_hook_process(qemu_rdma_registration_handle) {
>        do {
>            // this is a RDMA own control block, should not be disturbed by the common migration control path.
>            // head will be extracted and processed here.
>            // qio_channel_rdma_writev() will send RDMA_CONTROL_QEMU_FILE, which is an unexpected message for this block.
>            // head.repeat will be examined before the type, so an uninitialized repeat will confuse us here.
>        } while (!RDMA_CONTROL_REGISTER_FINISHED || !error)
>     }
> }
>
>
> when qio_channel_rdma_writev() is used for common migration control path, repeat is useless and will not be examined.
>
> With this patch, we can quickly know the cause.
>

Ah, right. Somehow I interpreted the commit message as meaning the
'type' field was bogus. But it's the 'repeat' field that causes the
issue. Thanks for the explanation.

Reviewed-by: Fabiano Rosas <farosas@suse.de>


