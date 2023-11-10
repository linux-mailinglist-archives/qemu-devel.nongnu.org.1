Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F687E788F
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 05:16:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Iud-0004hE-Qh; Thu, 09 Nov 2023 23:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1r1Iub-0004gx-9k
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 23:14:29 -0500
Received: from cyan.elm.relay.mailchannels.net ([23.83.212.47])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1r1IuZ-0002oc-6k
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 23:14:29 -0500
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id EFCAF9417CA;
 Fri, 10 Nov 2023 04:14:18 +0000 (UTC)
Received: from pdx1-sub0-mail-a213.dreamhost.com (unknown [127.0.0.6])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 5FB5F941A28;
 Fri, 10 Nov 2023 04:14:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1699589658; a=rsa-sha256;
 cv=none;
 b=vPsDuXEdOEk0ec1wvHpC756iJ2z8N+7I5yBlLgbYoOyTigKhz4FC7dk+gHYZ8YegD2VkMO
 piaABhHd2MfWQZKYZ0mP/7Ja2RVDdJakEbiShvfQfz6iNmp85hyHz+f+D+2ykzXp1wXi9B
 uUOZhKHT1v9XBTF97MHskJqjj7V3CMdNIKpiq9nZq7/q5teLttr97oW8g3NX9rYjK3hLjn
 r4g/hwRkiltn50VkhS4VonXd/lczklnwktWR8Ygl11UkVUMvywsv0FIntaRx+7zpKQ6X4/
 pI+psClPvjNrmrdx/T4ye6ng44wCk4jDy7KCSsR+KAq7sLEp3Yp44FOSiwauXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1699589658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=6984z1NIOWS2cpyIb22Xhe7fHQTdixUPvnTWV5lYTwQ=;
 b=n3l4f2RkDEvNPcU1wJxH6AA9im87qFWDUp4Tc+BSbNyOFGU60YR8VmcWdLcL6PmsBwH1hm
 NhbpJhigWEcnF9moIL+rPJuC12Yem6dNNfTdnuhWvIVbOqdl4THM4dAHE8NsNaAC6jW00c
 LGq8zqU+oroJH9QiUHwwKnQEfvs6ToCmbsQqOhTG3CXPH46he8NV8AImWyB8ABZ+lR0ooi
 ncsLgLddm0B4OSkC2kCtJRijoMjbKCl/0H9y1G3cjzpH+hyNnoFhiw1CQF/POlcS67E6uO
 +iWoLqW/IYOlkztYHB3KAQrctojLb3h26qLjsUjRH/HJraPgIYK3CLp1K++wMw==
ARC-Authentication-Results: i=1; rspamd-6f98f74948-hv59k;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lyrical-Wiry: 521e81ad19226f11_1699589658796_648408952
X-MC-Loop-Signature: 1699589658796:754804174
X-MC-Ingress-Time: 1699589658796
Received: from pdx1-sub0-mail-a213.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.127.137.45 (trex/6.9.2); Fri, 10 Nov 2023 04:14:18 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a213.dreamhost.com (Postfix) with ESMTPSA id 4SRQST5t8dz8w; 
 Thu,  9 Nov 2023 20:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1699589658;
 bh=6984z1NIOWS2cpyIb22Xhe7fHQTdixUPvnTWV5lYTwQ=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=DklkKfpB82w6RW+R7o//lwlRnlgWxQm42hl3by7b6Pjr8+SwUtbAn9nbxCmYNJnHM
 j508PTkAtWov9CSMzyqrSermiIP/er4ih0xCt1bIIDAgCHO+FTZmPALdS0uf2olxLQ
 wFhHB/yZ2l0y4OLlmmtU5ylcd4ClfviPGFaB9yL0kJOq+ibz3BMNPP6kMqt1kvSJr8
 C/WU2Ebsejn21/o7DsS4ZoodYmOz17uVaEPH0v+aPbCUtvF9S7e3vUVLi2bBUB9Wy5
 lEkuH8oRmVQ85bA88NgZQBElh6XXAQp/juV8LiR23AxTmmCkmEFO/pWl5DTXI+fA2H
 zzixEPrXA6fPw==
Date: Thu, 9 Nov 2023 20:14:14 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PULL 57/63] hw/cxl: Add support for device sanitation
Message-ID: <ooqk6xg4ate3n5mx5si5zluejkitmitre4oxvu32ttiu2be4ox@n6wsuvgshcis>
References: <cover.1699351720.git.mst@redhat.com>
 <25a52959f99d6860a186175bda898e3bdb605f91.1699351720.git.mst@redhat.com>
 <CAFEAcA8Hed0Av2PCZBmwkO8mj+qzSsZqt10funKOyXTmo7gu4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Hed0Av2PCZBmwkO8mj+qzSsZqt10funKOyXTmo7gu4g@mail.gmail.com>
User-Agent: NeoMutt/20231006
Received-SPF: pass client-ip=23.83.212.47; envelope-from=dave@stgolabs.net;
 helo=cyan.elm.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 09 Nov 2023, Peter Maydell wrote:

>On Tue, 7 Nov 2023 at 10:13, Michael S. Tsirkin <mst@redhat.com> wrote:
>>
>> From: Davidlohr Bueso <dave@stgolabs.net>
>>
>> Make use of the background operations through the sanitize command, per CXL
>> 3.0 specs. Traditionally run times can be rather long, depending on the
>> size of the media.
>>
>> Estimate times based on:
>>          https://pmem.io/documents/NVDIMM_DSM_Interface-V1.8.pdf
>>
>
>Hi; Coverity points out dead code in this function (CID 1523905):

Thanks for reporting.

>
>> +/*
>> + * CXL 3.0 spec section 8.2.9.8.5.1 - Sanitize.
>> + *
>> + * Once the Sanitize command has started successfully, the device shall be
>> + * placed in the media disabled state. If the command fails or is interrupted
>> + * by a reset or power failure, it shall remain in the media disabled state
>> + * until a successful Sanitize command has been completed. During this state:
>> + *
>> + * 1. Memory writes to the device will have no effect, and all memory reads
>> + * will return random values (no user data returned, even for locations that
>> + * the failed Sanitize operation didn???t sanitize yet).
>> + *
>> + * 2. Mailbox commands shall still be processed in the disabled state, except
>> + * that commands that access Sanitized areas shall fail with the Media Disabled
>> + * error code.
>> + */
>> +static CXLRetCode cmd_sanitize_overwrite(const struct cxl_cmd *cmd,
>> +                                         uint8_t *payload_in,
>> +                                         size_t len_in,
>> +                                         uint8_t *payload_out,
>> +                                         size_t *len_out,
>> +                                         CXLCCI *cci)
>> +{
>> +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>> +    uint64_t total_mem; /* in Mb */
>> +    int secs;
>> +
>> +    total_mem = (ct3d->cxl_dstate.vmem_size + ct3d->cxl_dstate.pmem_size) >> 20;
>> +    if (total_mem <= 512) {
>> +        secs = 4;
>> +    } else if (total_mem <= 1024) {
>> +        secs = 8;
>> +    } else if (total_mem <= 2 * 1024) {
>> +        secs = 15;
>> +    } else if (total_mem <= 4 * 1024) {
>> +        secs = 30;
>> +    } else if (total_mem <= 8 * 1024) {
>> +        secs = 60;
>> +    } else if (total_mem <= 16 * 1024) {
>> +        secs = 2 * 60;
>> +    } else if (total_mem <= 32 * 1024) {
>> +        secs = 4 * 60;
>> +    } else if (total_mem <= 64 * 1024) {
>> +        secs = 8 * 60;
>> +    } else if (total_mem <= 128 * 1024) {
>> +        secs = 15 * 60;
>> +    } else if (total_mem <= 256 * 1024) {
>> +        secs = 30 * 60;
>> +    } else if (total_mem <= 512 * 1024) {
>> +        secs = 60 * 60;
>> +    } else if (total_mem <= 1024 * 1024) {
>> +        secs = 120 * 60;
>> +    } else {
>> +        secs = 240 * 60; /* max 4 hrs */
>> +    }
>
>Here we have an exhaustive if ladder that sets 'secs'. None
>of the values we might end up with are less than 4.
>
>> +
>> +    /* EBUSY other bg cmds as of now */
>> +    cci->bg.runtime = secs * 1000UL;
>> +    *len_out = 0;
>> +
>> +    cxl_dev_disable_media(&ct3d->cxl_dstate);
>> +
>> +    if (secs > 2) {
>> +        /* sanitize when done */
>> +        return CXL_MBOX_BG_STARTED;
>> +    } else {
>
>...but here we have an else clause for when secs <= 2,
>which can never happen.

Yeah in a later version this conditional was removed
altogether and always do the CXL_MBOX_BG_STARTED case.

https://lore.kernel.org/linux-cxl/20230418172337.19207-5-dave@stgolabs.net/

I will send a patch.

Thanks,
Davidlohr

>> +        __do_sanitization(ct3d);
>> +        cxl_dev_enable_media(&ct3d->cxl_dstate);
>> +
>> +        return CXL_MBOX_SUCCESS;
>> +    }
>
>What was the intention here ?
>
>> +}
>
>thanks
>-- PMM
>

