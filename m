Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E211B7EDD80
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 10:20:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3YXn-0003ZU-Bo; Thu, 16 Nov 2023 04:20:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r3YXk-0003ZD-KI
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 04:20:12 -0500
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r3YXf-0002aF-7R
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 04:20:12 -0500
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-507e85ebf50so741456e87.1
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 01:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700126405; x=1700731205; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=P+83mzGPcTCEuRN4V/vbE0WFrnq4hzyjoU9q4zDERpA=;
 b=cUSigqrECfADNP3NrUlue+M4sOOQWuYhbqFuUKW18cWSjeFhuB0b/Cmjml1vuDhOcW
 q5MysiSqfUWQ0b0S7J2NCa93/Ih2LdE89X6JZ8jdosURKyxGgbStYM6rQ74ZI0lMYJgU
 kb3Fz/oo51NtdgzDBiwvabOzYdFGEPHDQBlneqmbDN4gm/Ld+3+J54e1yDQ2ZOD9PbRi
 Ttj1mon67CZUb8XqeTS/YZNV0tgqSRLxVIzPkyj15lFP5A/12A6KyNP/7c1S4XS/R1k9
 MnHKehZEi5tzvMVD1iGnDcohZn+2CPMiXrFFqDm5V9GYNFDzvP2lCcXDaKm3068uTBLq
 N8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700126405; x=1700731205;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=P+83mzGPcTCEuRN4V/vbE0WFrnq4hzyjoU9q4zDERpA=;
 b=d4S1+8pjT39LZQhMKIJ3oCxLg8qlA5NirjfUgXUb77OReHNJ8fsnBn2+bgf6wjgSTk
 GUFRFRIeHsSExr39loIc/0VH/gk3HwFTS7Ep/H/HgBaBv2y3Drl+UEA75QMth+tOVvAk
 ggoDHkQ4y6WOKtI3mYW3IzPpnTvqViFgy0pcd9L6sf0oQiLJeuQUXDVpZql7IMwpka1Q
 uf0LdwVLneL57FQB4Ep4/RO04ojKbje/BAmI3D2ICkXukQZBPd6LQ11plSyfbfQBqSAL
 G3SFtD8thbSsd6obJBMv+47KwpIjdfWXuJK8+PlJ04SGCEcT1K/0k1PPct2YTo5bXm3r
 Lr4A==
X-Gm-Message-State: AOJu0YwtOxFcsy4deqDLrkbI20unv0YelkAZXav6bvX5m8BIH++cugXT
 mduPaHSNDn0ThvYSLY+ci9tWdQ==
X-Google-Smtp-Source: AGHT+IHlccRFkIVtecwUQldCq3K/ySQAdX7Wt2QMr/xdP+vnxcsrgK4dOsmD1hA3p8bAd84h3shB1A==
X-Received: by 2002:a19:f819:0:b0:509:489f:d84e with SMTP id
 a25-20020a19f819000000b00509489fd84emr10357854lff.37.1700126405259; 
 Thu, 16 Nov 2023 01:20:05 -0800 (PST)
Received: from meli.delivery (adsl-149.37.6.3.tellas.gr. [37.6.3.149])
 by smtp.gmail.com with ESMTPSA id
 dn17-20020a0560000c1100b0032db1d741a6sm12726356wrb.99.2023.11.16.01.20.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Nov 2023 01:20:05 -0800 (PST)
Date: Thu, 16 Nov 2023 11:16:32 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Volker R=?UTF-8?B?w7w=?= melin <vr_qemu@t-online.de>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH-for-8.2] virtio-sound: add realize() error cleanup path
User-Agent: meli 0.8.2
References: <20231116072046.4002957-1-manos.pitsidianakis@linaro.org>
 <88363f15-697b-4b04-ad4d-af0aa5fb75aa@linaro.org>
 <47h4g.6wu5d10yw748@linaro.org>
 <688bc783-e56f-4e24-95f6-a69aa4bc8863@linaro.org>
 <47klp.p79qnee6q9fx@linaro.org>
 <3839ec93-8fc3-4e30-b554-6bb257e3da6d@linaro.org>
In-Reply-To: <3839ec93-8fc3-4e30-b554-6bb257e3da6d@linaro.org>
Message-ID: <47lxe.wzcd1i39zcr1@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, 16 Nov 2023 10:54, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>On 16/11/23 09:48, Manos Pitsidianakis wrote:
>> On Thu, 16 Nov 2023 10:42, Philippe Mathieu-Daudé <philmd@linaro.org> 
>> wrote:
>>> On 16/11/23 08:33, Manos Pitsidianakis wrote:
>>>> On Thu, 16 Nov 2023 09:32, Philippe Mathieu-Daudé <philmd@linaro.org> 
>>>> wrote:
>>>>>> ---
>>>>>>
>>>>>> Notes:
>>>>>>      Requires patch 
>>>>>> <20231109162034.2108018-1-manos.pitsidianakis@linaro.org>
>>>>>
>>>>> This is the 'Based-on: ' tag I guess.
>>>>
>>>> There is
>>>>
>>>>   prerequisite-patch-id: 484ec9f7f6109c10d4be0484fe8e3c2550c415f4
>>>
>>> $ git show 484ec9f7f6109c10d4be0484fe8e3c2550c415f4
>>> fatal: bad object 484ec9f7f6109c10d4be0484fe8e3c2550c415f4
>>>
>>> In which tree can we find this commit? Better to use the msg-id,
>>> so tools cat fetch prerequisite.
>>>
>>> I guess the 'patches' tool understand 'Based-on'. Or was it 'patchew'?
>> 
>> It's not a commit SHA, that's why. It's a sha produced by git-patch-id 
>> --stable. It hashes the diffs of the plain-text patch.
>> 
>> https://git-scm.com/docs/git-patch-id
>
>Hmm OK I didn't know, but not sure this could be useful in my patch
>workflow.

Didn't know either :) I found out because it's put there automatically 
by format-patch.

I just read in the qemu docs ("submitting a patch"):

   It is also okay to base patches on top of other on-going work that is 
   not yet part of the git master branch. To aid continuous integration 
   tools, such as patchew, you should add a tag line Based-on: 
   $MESSAGE_ID to your cover letter to make the series dependency 
   obvious.

So that settles it.

