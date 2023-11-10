Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D5567E7895
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 05:27:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1J5a-0006Za-4Z; Thu, 09 Nov 2023 23:25:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1r1J5V-0006ZQ-B1
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 23:25:45 -0500
Received: from hedgehog.birch.relay.mailchannels.net ([23.83.209.81])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dave@stgolabs.net>) id 1r1J5S-0005IR-8o
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 23:25:45 -0500
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 7E4C1901A65;
 Fri, 10 Nov 2023 04:25:40 +0000 (UTC)
Received: from pdx1-sub0-mail-a213.dreamhost.com (unknown [127.0.0.6])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 26470901A00;
 Fri, 10 Nov 2023 04:25:40 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1699590340; a=rsa-sha256;
 cv=none;
 b=LYbCZeOJxoE3dJY2rpon8G74Jysj/ko4bgJg7WMyWc5XvkWFtHjaeJ6+oLLbskJo55edz3
 tlR4kpBGqmkljyzrSRdA1XGwlQi8JX4XMmVPpyli9p+8oiLwwxrRhDB6/AfW21a9aIccbJ
 RaCZ8EIOHdibladNB6NWKdFK2LIk6q/kXih+Nl6tHy3mfWpPD94eepJalc+1/oBjFvCo2E
 vzgqfeSKyVArCANLbN6+3hKXa/sIZHrDcPSpe1HxR1Ln3KJDWbU/yFJ8DXu5/S7S6CVHUW
 EkQ1GIpQCsTfk9p93jcZfePChcV+ZDkrfQy3uxV6zd2zlkmuLXRf8KNFJz8ykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1699590340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=yCsSliowI7j1TTnZYPFOc8SnVcjhCJvHT+qKj++QKgs=;
 b=WBG1V0zImuNoHxQ/eb6nF6fAurt+tAOTgQHF3qrMybTpE70m8aN77pPOlNGPXPty85BFWp
 rYgvPCL2znhC1JWQt6Eqad+5M3SolseFFNxHLHDgYBLLykKaoLFRZVkwdrcXjnnxpPTClE
 e3zT6T2RVbX4L++hVW2AaB+LT1zV2//oQI3ZalOxChUzs/s3irWgpGyk4ve150RtZHDcy3
 f+zUDCKcxDPOkr8B/QMye1AZe53uhfZ48CjXSkaeeO1+CQoddRvl5nQ/7YCaNp0hcxk1ot
 1ABMANcuvTlsJg1CXq4Nwk3kTdn5fjkgei5NPZeibNt9a6/71lFaEUHt+WnqUg==
ARC-Authentication-Results: i=1; rspamd-6f98f74948-kkzxq;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Spicy-Share: 7dc342f8324fb558_1699590340313_1182019824
X-MC-Loop-Signature: 1699590340313:956425602
X-MC-Ingress-Time: 1699590340313
Received: from pdx1-sub0-mail-a213.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.124.29.34 (trex/6.9.2); Fri, 10 Nov 2023 04:25:40 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: dave@stgolabs.net)
 by pdx1-sub0-mail-a213.dreamhost.com (Postfix) with ESMTPSA id 4SRQjb2t25z2V; 
 Thu,  9 Nov 2023 20:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
 s=dreamhost; t=1699590339;
 bh=yCsSliowI7j1TTnZYPFOc8SnVcjhCJvHT+qKj++QKgs=;
 h=Date:From:To:Cc:Subject:Content-Type;
 b=fkjjlay/MbREvEwkMZ7nW1BetM3XjLXygpyTfhvtvFmUNUYY0LOU4cDcUm75vKh2i
 Di++kj5BKQgnkAXQ1R33KNKNIWYv0HBzCBZfUnX7cUN+rORMsqLXnpswTZoSz265cB
 abtg4tUDx799P/+J7ElxIVP2Ogyo9ZGFqRWMyRqRIWMF8k9yEjVBQLyYyVyiYKinWv
 zdZfucRcHYRwHWmvF6ia+jnhaaShv/7uiljxHvsWrnYhv3nWu8r8BzML3pR3Pwl/ZV
 CQ6UVr/4/u61o6OSt5WB2eYJadeHbX6flV25GR/+68UuVN2Rn8GsZYk4k5OkXOU8On
 uhAWVgHKdcMRQ==
Date: Thu, 9 Nov 2023 20:25:35 -0800
From: Davidlohr Bueso <dave@stgolabs.net>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PULL 55/63] hw/cxl/mbox: Add support for background operations
Message-ID: <kindookkjku4mwbwobap66e6r26hwvvtp5blra3dyjakla6pdk@57txir6kd6pi>
References: <cover.1699351720.git.mst@redhat.com>
 <221d2cfbdb5301f8f0cfbf26baf76544a5d71c27.1699351720.git.mst@redhat.com>
 <CAFEAcA-4UhUkokA8mbtk0D4NnJ7kShO9M60nOahLS1f=vFY=Kw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAFEAcA-4UhUkokA8mbtk0D4NnJ7kShO9M60nOahLS1f=vFY=Kw@mail.gmail.com>
User-Agent: NeoMutt/20231006
Received-SPF: pass client-ip=23.83.209.81; envelope-from=dave@stgolabs.net;
 helo=hedgehog.birch.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
>> Support background commands in the mailbox, and update
>> cmd_infostat_bg_op_sts() accordingly. This patch does not implement mbox
>> interrupts upon completion, so the kernel driver must rely on polling to
>> know when the operation is done.
>>
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> Message-Id: <20231023160806.13206-12-Jonathan.Cameron@huawei.com>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
>Hi; Coverity points out dead code in this function (CID 1523907):
>
>> +static void bg_timercb(void *opaque)
>> +{
>> +    CXLCCI *cci = opaque;
>> +    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
>> +    uint64_t bg_status_reg = 0;
>> +    uint64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
>> +    uint64_t total_time = cci->bg.starttime + cci->bg.runtime;
>> +
>> +    assert(cci->bg.runtime > 0);
>> +    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
>> +                               OP, cci->bg.opcode);
>> +
>> +    if (now >= total_time) { /* we are done */
>> +        uint64_t status_reg;
>> +        uint16_t ret = CXL_MBOX_SUCCESS;
>
>Here we set 'ret' to CXL_MBOX_SUCCESS...
>
>> +
>> +        cci->bg.complete_pct = 100;
>> +        /* Clear bg */
>> +        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, 0);
>> +        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
>> +
>> +        bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
>> +                                   RET_CODE, ret);
>
>...and nothing here changes 'ret'...
>
>> +
>> +        /* TODO add ad-hoc cmd succesful completion handling */
>> +
>> +        qemu_log("Background command %04xh finished: %s\n",
>> +                 cci->bg.opcode,
>> +                 ret == CXL_MBOX_SUCCESS ? "success" : "aborted");
>
>...but here we check whether ret is CXL_MBOX_SUCCESS or not:
>the "aborted" half of this condition is dead code.

Yeah this had also been removed in a later version:
https://lore.kernel.org/linux-cxl/20230418172337.19207-2-dave@stgolabs.net/

>
>A later commit adds an "if (ret == CXL_MBOX_SUCCESS) {" block
>where the TODO currently is, and that is an unnecessary check,
>because ret cannot be anything else at that point.

I'll send a patch along with the other dead code report.

Thanks,
Davidlohr

