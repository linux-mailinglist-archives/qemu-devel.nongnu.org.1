Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E76797459CD
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 12:12:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGGVU-0003f1-4B; Mon, 03 Jul 2023 06:10:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGGVH-0003F1-44; Mon, 03 Jul 2023 06:10:00 -0400
Received: from mail-oa1-x2b.google.com ([2001:4860:4864:20::2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qGGVE-0007CJ-SQ; Mon, 03 Jul 2023 06:09:54 -0400
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-1b012c3ce43so3537491fac.3; 
 Mon, 03 Jul 2023 03:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688378990; x=1690970990;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZVxIYkDIohU1O071DkHzLo9VU1FHSqQn6IdflZITeUA=;
 b=C2bmZlcc42qp1zl0HpngJ6idoIoU0NeC0t94kaHj5MZXkq74JqjOKBJheuOs8gyAO1
 pvvMVv1zpdGG1sbj30ocVf3L+EwYYOPMTLfhI4wkKrD5LLPw60PwGHbjkG6AXqVY/qn1
 TOhAYbdb65ajlVuDBMSxq02p5fXKKZIcz9onDnCTQvtKQd4EFx4P02tGlfwNYmbjM9gT
 UfDwV8jxeic1n9o3YXLgThoKaZkJvGAH9+hfTB/VLx0KtHZRVsy7P1rqCVSrGcSGN4sD
 CemdjCMpYWRF3tLGklTqrqXxXgXuNVRZIG1AioOToXpJmUF8NaXR6CpfcvXkOdofV0wv
 YnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688378990; x=1690970990;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZVxIYkDIohU1O071DkHzLo9VU1FHSqQn6IdflZITeUA=;
 b=aB1y2HsBbV8CgQCgszHK3Z2sA2V1Nljwr/LiOUerHDJ5eqHsbX6gfWFCZ1Hv7wp4W0
 pX6lPIUOvZMgPUpSTgM6iNHD4tdCEw3cgFCaeGL16PT2cqqXoTynM3wj8I5y9GnDWSVM
 Wse1UIO2UWVzw75uzg69iwQWGfQlI23u4U5MQ/emALNLKyts2ptFJfYOKAcLldRf36ec
 xM67YXug2zN/usfPuSQJ5R7OGqQpWcTVdQ+08XNqZZyWdbuArXL/kTf0ImVRyQQY4IQH
 tXjf0AouvuYVbNIkB07syMFx+uuubXhCrQW//4qSHlg7bKZ9rCzSTElJIXzVDCG3Pid0
 SkAg==
X-Gm-Message-State: ABy/qLZeEO7qXkzYlXUKvv2ZHy0723VsoLOq0PmsM13dH/lCnkBvDCfm
 KuNLVL0CguGQjSjHNywEIc0=
X-Google-Smtp-Source: APBJJlF4SVE5NUvPI5L0H1xMJ5m4b2Ee66F5YFgwp75F9Et7vpXvm+2E/JzG62T8XKSYn2AoixCOPg==
X-Received: by 2002:a05:6870:9d8b:b0:17a:c612:ae0d with SMTP id
 pv11-20020a0568709d8b00b0017ac612ae0dmr12280715oab.49.1688378990134; 
 Mon, 03 Jul 2023 03:09:50 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 f39-20020a056871072700b001a69e7efd13sm12307824oap.5.2023.07.03.03.09.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Jul 2023 03:09:49 -0700 (PDT)
Message-ID: <a1caa536-f625-f071-cfd0-60773fafdb2b@gmail.com>
Date: Mon, 3 Jul 2023 07:09:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 00/14] Misc clean ups to target/ppc exception handling
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org,
 Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>
References: <cover.1686868895.git.balaton@eik.bme.hu>
 <92e3591e-cce7-c3e7-7d73-a0bd24de8c2c@gmail.com>
 <1726bfcd-0e6e-0a72-bc97-be7a79f95340@eik.bme.hu>
 <03e0c0c0-d3e5-bc4c-6c07-db642d2e6f52@gmail.com>
 <275e9cc3-8cb5-052a-7683-7abf4ea78522@eik.bme.hu>
 <a314ebf0-fede-2646-a255-59ee9ebf33d6@gmail.com>
 <a7502abc-8186-134f-6019-771c1afc27fc@eik.bme.hu>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <a7502abc-8186-134f-6019-771c1afc27fc@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2b;
 envelope-from=danielhb413@gmail.com; helo=mail-oa1-x2b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.09,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 7/2/23 09:36, BALATON Zoltan wrote:
> On Sat, 1 Jul 2023, Daniel Henrique Barboza wrote:
>> On 7/1/23 06:39, BALATON Zoltan wrote:
>>> On Sat, 1 Jul 2023, Daniel Henrique Barboza wrote:
>>>> On 6/30/23 19:57, BALATON Zoltan wrote:
>>>>> On Fri, 30 Jun 2023, Daniel Henrique Barboza wrote:
>>>>>> Patches 1, 2, 3, 5, 7 and 11 are queued.
>>>>>>
>>>>>> If you would be so kind to get the remaining patches, rebase them
>>>>>> on top of my ppc-next and resend, I believe there's more stuff
>>>>>> to be queued.
>>>>>
>>>>> Thanks for taking care of these. I'll do the rebase of remaining patches once the current queue is merged, they aren't urgent so I can come back to those later. I'm working on some sam460ex patches but don't know yet when can I send it so don't wait for me now.
>>>>
>>>> Got it. Just bear in mind the current release schedule. Code freeze is July 11th:
>>>>
>>>> https://wiki.qemu.org/Planning/8.1
>>>>
>>>> I'll send one last PR before freeze (probably on July 10th) and then it'll be only bug fixes until end of August.
>>>
>>> Do you mean one more last PR after merging the current queue or the current queue will only be in that last PR? I hoped there would be a PR now on which I can rebase the outstanding patches for the last PR so I don't have to rebase on next but if the only PR you plan is the last on 10th then I may need to move to ppc-next now.
>>
>> Just use ppc-next right now.
>>
>> Even if I send a PR today with what we have, Peter/Richard has no obligation of merging it quickly on Monday (there's an US holiday July 4th, and some people will also skip July 3rd). If you wait for such PR to merge upstream, then start rebasing your stuff, you'll have less time to work with.
> 
> They may not be in the US though. Anyway, I've tried to rebase the remaining patches on your ppc-next branch and they applied without changes so not sure what you need from me now. I think Nick had alternative versions of the checkstop and sc patches that may cause a rebase when then go in first. Do you want me to merge them and submit that as a series with my patches? I don't have much time for now and these are just clean ups so I can live with these missing the next release and can come back to it later. I may try to do some sam460ex clean ups instead that should not clash with anything else.

I'm fine with leaving some of these cleanups for the next release. I might review
some patches by myself and queueing them during this week.


Daniel

> 
> Regards,
> BALATON Zoltan

