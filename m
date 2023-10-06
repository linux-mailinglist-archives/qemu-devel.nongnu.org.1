Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB21B7BB6F8
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:52:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qojMr-00039V-NR; Fri, 06 Oct 2023 07:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mie@igel.co.jp>) id 1qojMm-000396-H1
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:51:37 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mie@igel.co.jp>) id 1qojMj-00046h-Ss
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:51:36 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-692c02adeefso1696955b3a.3
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 04:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1696593091; x=1697197891;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rvlaPDr0ZaJ1x37a2ONF6H4ToXENQDx2tAlrZ4vOKTQ=;
 b=e+9of9qxJp8K9hziRhP/j6buzWEanrEp5yn4r4k1LWDTfwJuP5MxQDrZOReTuoDs4W
 6f83qiSqO5ahRPlmbPQ0W9+J5vp67e6OicoruQg9HAfE+jJNYJW58fQ6/m8BOq2jTYyC
 oJWZaVoZelh2HaimgcJI85ohlkwA5i4RGVKDbH677wCFHtE8BvZeUKu4xY3K/ezoy/cf
 OHpZadlyB1YdaXuxBGHa8OGClXuLEkKs28qKgDS8+FtkEZAg+92Jo3k2G2BahJZylJdG
 E6MTw1ZSuO+p1iO9zNfGS47RNmNcYV/v9dQVBsqwMtJ4HWey0lFpumOs3fGBIwMnHSMC
 ZE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696593091; x=1697197891;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rvlaPDr0ZaJ1x37a2ONF6H4ToXENQDx2tAlrZ4vOKTQ=;
 b=ev5aiTSXGlkbLz/R3OYfBArUtIEBKbjYKysgpVE38p8E9xLTXBmKbGiCxqkkXXFwNm
 inuWk/uKbbaUToxnw15VLGsGY+H0HWORm06BkHRvGGrGSlXMt0XfNoWZbPEBp4PvVcI7
 bn017OYPUctyfoshRa8tsQGzR4UhaSTvxCuaasauCWhB3YwGYP1QWiXf6Hl4qHupRhpc
 npQTZ5DP/P8HH88OtHDxezWpJ10nC9XQu0/N/EjXA26rfNDWg+0HR7neBF5TOuH/YpUg
 ryHX/zvZqdqv/WspI/EReYFlKbkeGOWmLGHU7DmohIoMXxns8Ku+VKsRQSSvLljZ/MPs
 x9xw==
X-Gm-Message-State: AOJu0Ywob3WsjhYwOljLsLFjNJIzUbBW1cgbCMc9rfUpdNRZKTmSC8+9
 zwZz4twfY4KJOnz9S08xwxMs4g==
X-Google-Smtp-Source: AGHT+IFR5hqtYTXozK4kSlJkLHQDyAnNdUmjKDyiuo+Xn23zdFBiJ3GnlASYbFinkoIkYM4FK6OUcw==
X-Received: by 2002:a05:6a20:8419:b0:161:2389:e34b with SMTP id
 c25-20020a056a20841900b001612389e34bmr9981678pzd.13.1696593091546; 
 Fri, 06 Oct 2023 04:51:31 -0700 (PDT)
Received: from [10.16.161.199] (napt.igel.co.jp. [219.106.231.132])
 by smtp.gmail.com with ESMTPSA id
 u23-20020a62ed17000000b006884844dfcdsm1264512pfh.55.2023.10.06.04.51.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Oct 2023 04:51:31 -0700 (PDT)
Message-ID: <88775092-78d7-d1b6-100b-369079ff979b@igel.co.jp>
Date: Fri, 6 Oct 2023 20:51:26 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC] Proposal of QEMU PCI Endpoint test environment
Content-Language: en-US
To: Mattias Nissler <mnissler@rivosinc.com>
Cc: cz172638@gmail.com, bhelgaas@google.com,
 Jagannathan Raman <jag.raman@oracle.com>, kishon@kernel.org,
 kvijayab@amd.com, kw@linux.com, levon@movementarian.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org, robh@kernel.org, thanos.makatos@nutanix.com,
 vaishnav.a@ti.com, william.henderson@nutanix.com
References: <CAGNS4TbhS3XnCFAEi378+cSmJvGMdjN2oTv=tES36vbV4CaDuA@mail.gmail.com>
 <CANXvt5qKxfU3p1eSK4fkzRFRBXHSVvSkJrnQRLKPkQjhsMGNzQ@mail.gmail.com>
 <CAGNS4TbAgqRQepv=fMoUxo02Qea5S9LwWFm-jjt1ej8DdLjshw@mail.gmail.com>
From: Shunsuke Mie <mie@igel.co.jp>
In-Reply-To: <CAGNS4TbAgqRQepv=fMoUxo02Qea5S9LwWFm-jjt1ej8DdLjshw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=mie@igel.co.jp; helo=mail-pf1-x435.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-2.797, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


On 2023/10/05 16:02, Mattias Nissler wrote:
> On Thu, Oct 5, 2023 at 3:31 AM Shunsuke Mie <mie@igel.co.jp> wrote:
>> Hi Jiri, Mattias and all.
>>
>> 2023年10月4日(水) 16:36 Mattias Nissler <mnissler@rivosinc.com>:
>>>> hi shunsuke, all,
>>>> what about vfio-user + qemu?
>> Thank you for the suggestion.
>>
>>> FWIW, I have had some good success using VFIO-user to bridge software components to hardware designs. For the most part, I have been hooking up software endpoint models to hardware design components speaking the PCIe transaction layer protocol. The central piece you need is a way to translate between the VFIO-user protocol and PCIe transaction layer messages, basically converting ECAM accesses, memory accesses (DMA+MMIO), and interrupts between the two worlds. I have some code which implements the basics of that. It's certainly far from complete (TLP is a massive protocol), but it works well enough for me. I believe we should be able to open-source this if there's interest, let me know.
>> It is what I want to do, but I'm not familiar with the vfio and vfio-user, and I have a question. QEMU has a PCI TLP communication implementation for Multi-process QEMU[1]. It is similar to your success.
> I'm no qemu expert, but my understanding is that the plan is for the
> existing multi-process QEMU implementation to eventually be
> superseded/replaced by the VFIO-user based one (qemu folks, please
> correct me if I'm wrong). From a functional perspective they are more
> or less equivalent AFAICT.
>
The project is promising.

I found a session about the vfio adapts to Multi-process QEMU[1] in KVM 
Forun 2021, butI couldn't found some posted patches.
If anyone knows status of this project, could you please let me know?

[1] https://www.youtube.com/watch?v=NBT8rImx3VE
>> The multi-process qemu also communicates TLP over UDS. Could you let me know your opinion about it?
> Note that neither multi-process qemu nor VFIO-user actually pass
> around TLPs, but rather have their own command language to encode
> ECAM, MMIO, DMA, interrupts etc. However, translation from/to TLP is
> possible and works well enough in my experience.
I agree.
>>> One thing to note is that there are currently some limits to bridging VFIO-user / TLP that I haven't figured out and/or will need further work: Advanced PCIe concepts like PASID, ATS/PRI, SR-IOV etc. may lack equivalents on the VFIO-user side that would have to be filled in. The folk behind libvfio-user[2] have been very approachable and open to improvements in my experience though.
>>>
>>> If I understand correctly, the specific goal here is testing PCIe endpoint designs against a Linux host. What you'd need for that is a PCI host controller for the Linux side to talk to and then hooking up endpoints on the transaction layer. QEMU can simulate host controllers that work with existing Linux drivers just fine. Then you can put a vfio-user-pci stub device (I don't think this has landed in qemu yet, but you can find the code at [1]) on the simulated PCI bus which will expose any software interactions with the endpoint as VFIO-user protocol messages over unix domain socket. The piece you need to bring is a VFIO-user server that handles these messages. Its task is basically translating between VFIO-user and TLP and then injecting TLP into your hardware design.
>> Yes, If the pci host controller you said can be implemented, I can achieve my goal.
> I meant to say that the existing PCIe host controller implementations
> in qemu can be used as is.
Sorry, I misunderstood.
>> To begin with, I'll investigate the vfio and libvfio-user.  Thanks!.
>>
>> [1] https://www.qemu.org/docs/master/system/multi-process.html
>>
>> Best,
>> Shunsuke
>>>
>>> [1] https://github.com/oracle/qemu/tree/vfio-user-p3.1 - I believe that's the latest version, Jagannathan Raman will know best
>>> [2] https://github.com/nutanix/libvfio-user
>>>

