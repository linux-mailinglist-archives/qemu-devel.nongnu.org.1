Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3577F5F94
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 13:55:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r69Di-0000l9-2A; Thu, 23 Nov 2023 07:54:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r69Dg-0000ks-Ar
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 07:54:12 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1r69De-0000fy-J5
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 07:54:12 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-32df66c691dso554985f8f.3
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 04:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1700744049; x=1701348849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HZIchAkcO0//9C5nqftIicLiV2zh6+6vSKtm2NieiM0=;
 b=F7CCmDQdz7djIUY5IJ6IYJDLFh9asIm1aGebPKjKi1VqosEwkOlKMWKLT7qkNx3WZL
 lZajZLuiojSu5oCulY7lK5Z1QRB1A+I92YJSLTHPKnH++NR5Oaao8dgmKSjKTfLeQ/xq
 I9d7ImC4ITMKKChehHkOLUWYW0HHLS80xD//uziSBgc7Zwv9EsbNfRuj3H7OOPM4yCUp
 FPCQ2TkC0bzYwA1Hg7KHcXpW/qz01YefwdOetuEEFUvU2GFBfVxh177IOfL//qbi1JPo
 +juPveDyUDTtd9JPKulkdcl62L3vzrfVr8WoJKyFWCYBiG7tiQqZ7Ol24r5MftxnjKE2
 MHtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700744049; x=1701348849;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HZIchAkcO0//9C5nqftIicLiV2zh6+6vSKtm2NieiM0=;
 b=DQH2S0iEReGCsyKG8OOadkfGLBZ/2OhTlQrYWQZIRQ/KjBtNsSUJ53qIsOfseJgj09
 1Qgq5ETWDFxklTsmvjXus8/vftVJaQ3iJ86ty462JGElhRGhx9OIGSuJMx4JVrvNuC+e
 BUmIY+kv8Ro8L6W6tUhL89y10kksipK2I6CXhOz4HSox8xXhyipVcxzI+AzW7rhLyoA0
 dtqj+JSjutyYeNB3DnGGd9EYSWcZoW03XyJgqt3k0cswaRG61qPgFkuPAQWVrdnIf40V
 VRkI0SMD2ZGSlHz0navDF5AHAFwkLzEMBxay4Zhi8S91h85cQabjzAxwAisw93sjM4wI
 Tvcg==
X-Gm-Message-State: AOJu0YwSRHyKcxQp8rBjDRqSfmE9nD/bKRRTOKpgis3YjMFs4LTHxb8S
 86kLPg7MQBf9gDfCXj613VQ=
X-Google-Smtp-Source: AGHT+IFujjuk0/ucGpYUlc6IACHFhCshwdqxfv5BZ3tZlcL7bRzD1bBfZyNAYEFctx1owHEK4qc5Hg==
X-Received: by 2002:a5d:5983:0:b0:32d:5870:8b8a with SMTP id
 n3-20020a5d5983000000b0032d58708b8amr3092264wri.56.1700744048752; 
 Thu, 23 Nov 2023 04:54:08 -0800 (PST)
Received: from [192.168.13.100] (54-240-197-239.amazon.com. [54.240.197.239])
 by smtp.gmail.com with ESMTPSA id
 x12-20020adff64c000000b0032dcb08bf94sm1590693wrp.60.2023.11.23.04.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 04:54:08 -0800 (PST)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <ef7bed62-03b4-4759-8366-730ec6f3004b@xen.org>
Date: Thu, 23 Nov 2023 12:54:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/6] xen_pvdev: Do not assume Dom0 when creating a
 directory
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>,
 Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Julien Grall <julien@xen.org>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
 <20231121221023.419901-5-volodymyr_babchuk@epam.com>
 <b04daedc-ba6a-4109-8e23-fbcd023bcfec@xen.org>
 <alpine.DEB.2.22.394.2311221428570.2053963@ubuntu-linux-20-04-desktop>
 <ce719f35e72a9387fc04af098e6d688f9bbdca4e.camel@infradead.org>
 <alpine.DEB.2.22.394.2311221508270.2424505@ubuntu-linux-20-04-desktop>
 <a4e6a62a7cfe756344a1efcb8b2c3cfb1e50817e.camel@infradead.org>
 <alpine.DEB.2.22.394.2311221515010.2424505@ubuntu-linux-20-04-desktop>
 <87r0khz6zj.fsf@epam.com> <87cyw1z61i.fsf@epam.com>
 <dce4efb0-4fdc-404c-8e5d-c90ed732eb8a@xen.org> <87bkbky9bb.fsf@epam.com>
 <5941AF2D-71E7-4A5B-A519-25F87F90DC05@infradead.org>
 <87v89swtmz.fsf@epam.com>
 <C2DEE963-41CB-4377-93FD-BD9FB500926F@infradead.org>
Organization: Xen Project
In-Reply-To: <C2DEE963-41CB-4377-93FD-BD9FB500926F@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=xadimgnik@gmail.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 23/11/2023 12:27, David Woodhouse wrote:
> On 23 November 2023 12:17:57 GMT, Volodymyr Babchuk <Volodymyr_Babchuk@epam.com> wrote:
>>
>> Hi David,
>>
>> David Woodhouse <dwmw2@infradead.org> writes:
>>> Which PV backends do you care about? We already have net, block and console converted.
>>
>> Well, this is all what we need, actually. Even console only will be
>> sufficient, as we are using QEMU to provide virtio-pci backends, so both
>> storage and networking should be provided by virtio. Are you proposing
>> to just drop this patch at all? I believe we can live without it, yes.
> 
> Yeah, I think you can drop anything that's only needed for the legacy backends. I'm tempted to make a separate config option to compile those out.
> 

I think that would be a good idea. The other legacy bacckend that we may 
need to care about is xenfb... not so much the framebuffer itself, but 
the mouse and keyboard aspects. The XENVKBD and XENHID drivers expose PV 
mouse and keyboard to Windows instances so it's be nice if we can avoid 
the backend withering away.

   Paul

