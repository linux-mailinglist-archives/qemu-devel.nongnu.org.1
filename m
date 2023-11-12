Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD157E8DA7
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 01:38:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1yTT-0005q1-Ho; Sat, 11 Nov 2023 19:37:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christopherericlentocha@gmail.com>)
 id 1r1yTS-0005pW-AB
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 19:37:14 -0500
Received: from mail-io1-xd2b.google.com ([2607:f8b0:4864:20::d2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christopherericlentocha@gmail.com>)
 id 1r1yTQ-00036p-U9
 for qemu-devel@nongnu.org; Sat, 11 Nov 2023 19:37:14 -0500
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-7ac61c58d85so136448139f.2
 for <qemu-devel@nongnu.org>; Sat, 11 Nov 2023 16:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699749431; x=1700354231; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Dd4UY8aKBtk6BoqYKkbWbSo1ELHAWMoMacbdKi4IVuQ=;
 b=jbNdS38Ch+tF1jJ+Shh/kd5fVaDy8sajkf+Ytg5Y/rUsABo/3hRKwhPILe7rJVH2Az
 XLjgQKky1x3wxZlNB3cJzlPzhL7p2O96JeV879BmW3NQctyBDklstP+ickmu+Zh4/n8u
 sid8hkGDv8BO5+qqYMCjAbIclUHFufUPT1PuOWhEXlDucgRfFEhfY0DpTOS8sUwbto0j
 zv3HVoB/0vlnBrNrip7bCUPH6uFzjSocazYrPqB91ekHLedU58KEqu83BN3HHZ/R6Bzy
 KUR1i2fOuCciMl4l6RicWQd5bId9e0jTa3kskgmZWpgn1m3/HOfq5cmwToxOEIDD47k8
 hOZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699749431; x=1700354231;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Dd4UY8aKBtk6BoqYKkbWbSo1ELHAWMoMacbdKi4IVuQ=;
 b=DkH4bvQoNzPCotRTkiD8ewHjX775xJ0gQL6szEQRyJc6pY1ScQYQXKOvyiivKE8IrA
 BdQUlU/RLWlOCRxlxT73UCg1lL6RGV34deb22W8E0ov/towUq4EHZ+XNm5ki4mnr8LDa
 7Maj7xysAszER/LRIlhJY+PwjV2ktsnO6R3frdNTXZZWApWMTiNZgmG1p0XU15pn2pvy
 d/cO9tn/5FB0xP2q3JwRsh4tSNNmQC6rf4fABEof+SnMWHM2gK8NbXxdncn4vjD4SXvN
 ZRabLPkIYjV9LaHWSRNWgtWFl9T5hYRaH/nZbiw0QhX+idQMdlRCi/1GpPdQFMv7V1Z/
 EatA==
X-Gm-Message-State: AOJu0Yzuu7xbNYhzfc2ubMAVRY0d6Vtxea58ERbg8uiT1G65+k7bC6xX
 l024hKAU8ONvSBIoisADJaA=
X-Google-Smtp-Source: AGHT+IGXwRAUU+XPED8/MNE1JMDuFjIQqk/IqG452OMlUu+drjareWJLoHP6yuwiSw3G3UpdjMGv2g==
X-Received: by 2002:a05:6602:3415:b0:7a9:4207:289d with SMTP id
 n21-20020a056602341500b007a94207289dmr5634296ioz.10.1699749431104; 
 Sat, 11 Nov 2023 16:37:11 -0800 (PST)
Received: from [192.168.1.4] (172-8-197-221.lightspeed.livnmi.sbcglobal.net.
 [172.8.197.221]) by smtp.gmail.com with ESMTPSA id
 b19-20020a056638389300b00464556794a0sm744207jav.3.2023.11.11.16.37.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Nov 2023 16:37:10 -0800 (PST)
Message-ID: <dcb9ee68-2839-f2f4-f9c1-46a149a315f8@gmail.com>
Date: Sat, 11 Nov 2023 19:37:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH] Fix Windows 2000 and XP HDAudio Support
To: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Volker_R=c3=bcmelin?=
 <vr_qemu@t-online.de>
References: <737e8de1-9c14-453e-35eb-bff1e6b34a4a@gmail.com>
 <1b3f57dd-7a3f-4630-b1e1-298578bbc5b7@linaro.org>
 <lfrzsbncmlbxoelzt4asbctne5wq7mnjtv6yo3kc6nroocxsdc@45urch4n6pi4>
Content-Language: en-US
From: Christopher Lentocha <christopherericlentocha@gmail.com>
In-Reply-To: <lfrzsbncmlbxoelzt4asbctne5wq7mnjtv6yo3kc6nroocxsdc@45urch4n6pi4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2b;
 envelope-from=christopherericlentocha@gmail.com; helo=mail-io1-xd2b.google.com
X-Spam_score_int: -62
X-Spam_score: -6.3
X-Spam_bar: ------
X-Spam_report: (-6.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 NICE_REPLY_A=-4.148, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

So wait, you want me to add it as another device name? Because 
it is going to be the same exact way as the 1af4 device
just with a number change. Ok, work it is then ...
(Sorry about not getting back sooner also)

Christopher

On 11/8/23 6:12 AM, Gerd Hoffmann wrote:
> On Wed, Nov 08, 2023 at 11:02:06AM +0100, Philippe Mathieu-Daudé wrote:
>> Thanks Christopher for your patch,
>>
>> I'm Cc'ing Volker and Gerd who know better this hardware model.
>>
>> On 7/11/23 20:27, Christopher Lentocha wrote:
>>>
>>> Change the ID to be a Realtek ALC885 so that both
> 
> No.  Rewriting the existing codecs is clearly a non-starter.
> 
> You can add a 'hda-realtek-alc885' variant which tries to
> mimic the realtek coded close enough to make old guests
> without generic hda driver happy.
> 
>>> +#define QEMU_HDA_ID 0x10EC0885
> 
> Nope.  Somemething like 'REALTEK_ALC885_ID' please.
> 
> [ remaining bits of the patch snipped, needs major rework ]
> 
> take care,
>   Gerd
> 

