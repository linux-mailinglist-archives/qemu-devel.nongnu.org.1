Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0C97C6AB0
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 12:13:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqsfl-0005rc-0G; Thu, 12 Oct 2023 06:12:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qqsfh-0005rO-Tu
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:12:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qqsfg-0003Fo-8H
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 06:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697105518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0wsuXMhpsjdmFmjugjKWWdMVeJuUqaabLv6Nh8Z0/S4=;
 b=GQeOH6O57d1kUXhiwS3axfc0K5dmFLH1ZEOmWf4/0xyClUkgpg5O/YUu+n+lhLRvyYjp6D
 ZARcmNOJZzvvTvXzrEDkiWkIe9IwqlPgDo24c8l+ilnPYIdJqMvpujL8rO3PHBzMDH5/On
 cUDLjS8qOLQME4GOVIl3amqEGcvau7I=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-p0O2iPDCNeWBbjQzR6jZyw-1; Thu, 12 Oct 2023 06:11:56 -0400
X-MC-Unique: p0O2iPDCNeWBbjQzR6jZyw-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6564dbde089so29196016d6.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 03:11:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697105515; x=1697710315;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0wsuXMhpsjdmFmjugjKWWdMVeJuUqaabLv6Nh8Z0/S4=;
 b=tuGJkMi7/i26TtI2K0C64c8F+39fMgJdwCSbZSaF8XqHDc7eyhWlVPmdTxjdxdmiTT
 W6rxGkRJ7N8MhuR+Sns2+tBp3gl9kmK5bt3Hvd9gT3nMvWDnpoKpp2u5z5MNEYtdmXF4
 aPxQMinzdTC/eYMuSI8Cu9M4kazHt4IvW04H73iHVdzcvlUs+hLyTcWUzoKFjup4/8Nt
 cNMTUJqpjJkCU8WkdyhOjT31yXOcU5XGkCU60UiBeE63dZwszN7ugECHn0vSq/lyMxvE
 iWvfYcDoTfFegVnhxoWWt7Ev0hvrYTx99LiuCG90OYN+zfH+crTEX1tV/rxbnvtHC0S8
 MJcA==
X-Gm-Message-State: AOJu0YxHDV+WN0Q0kvE5nRx+zRLjDMQVCgR04T5BbP3QklicH9HbSGEv
 SHXbgCGJSqAodCcE+NbMA2Bi5Ko36TX6VirL1+sNrTv8bdMsmdtVKdOmRo/2FkYb0DAru5slGeP
 Tr6Z7gX32HTAbuMg=
X-Received: by 2002:ad4:4d0b:0:b0:66d:1302:e278 with SMTP id
 l11-20020ad44d0b000000b0066d1302e278mr2092356qvl.19.1697105515687; 
 Thu, 12 Oct 2023 03:11:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3bNzS4wq+EUxjOEy1Wqq3BNsYelliNujSwyMMYvBcHUoyVXOb0/CilmU4B9VGOz8TAoCuMQ==
X-Received: by 2002:ad4:4d0b:0:b0:66d:1302:e278 with SMTP id
 l11-20020ad44d0b000000b0066d1302e278mr2092343qvl.19.1697105515426; 
 Thu, 12 Oct 2023 03:11:55 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 v14-20020a0c9c0e000000b006588bd29c7esm6466578qve.28.2023.10.12.03.11.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 03:11:54 -0700 (PDT)
Message-ID: <a99d25e9-dfa5-0699-5b46-aa5ab23f0b56@redhat.com>
Date: Thu, 12 Oct 2023 12:11:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 0/3] ramfb: migration support
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@gmail.com>,
 qemu-devel@nongnu.org, lersek@redhat.com
References: <20231009063247.119333-1-marcandre.lureau@redhat.com>
 <0cdcd25f-9ed5-cbfe-1633-213bd6a2c82f@redhat.com>
 <CAJ+F1CJ+yKL8aSg=OdBBHzdfsaRj+fvD8y1QLgxT4UbjxAbUZg@mail.gmail.com>
 <346b5a63-b477-5de8-fc93-65904b8ceda6@redhat.com>
 <foqw7o42pm7fys42zscstnfln77sof237j7slqcbupyximekba@p7uj37bce2nh>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <foqw7o42pm7fys42zscstnfln77sof237j7slqcbupyximekba@p7uj37bce2nh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/12/23 11:18, Gerd Hoffmann wrote:
> On Wed, Oct 11, 2023 at 07:09:19PM +0200, Cédric Le Goater wrote:
>> On 10/10/23 15:46, Marc-André Lureau wrote:
>>> Hi
>>>
>>> On Tue, Oct 10, 2023 at 4:49 PM Cédric Le Goater <clg@redhat.com> wrote:
>>>>
>>>> Hello,
>>>>
>>>> On 10/9/23 08:32, marcandre.lureau@redhat.com wrote:
>>>>> From: Marc-André Lureau <marcandre.lureau@redhat.com>
>>>>>
>>>>> Hi,
>>>>>
>>>>> Implement RAMFB migration, and add properties to enable it only on >= 8.2
>>>>> machines, + a few related cleanups.
>>>>
>>>> Should this series go in vfio-next ?
>>>>
>>>
>>> That's a good option for me.
>>
>> Gerd, fine with you ?
> 
> Yes.
> 
> Acked-by: Gerd Hoffmann <kraxel@redhat.com>



Thanks,

Applied to vfio-next.


C.


