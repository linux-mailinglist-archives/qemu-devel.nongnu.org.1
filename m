Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 263027DB263
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 05:04:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxJVJ-0004Ag-AS; Mon, 30 Oct 2023 00:03:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxJVA-00048B-2I
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:03:44 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qxJV7-0004Lk-K4
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 00:03:43 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-6be840283ceso3554209b3a.3
 for <qemu-devel@nongnu.org>; Sun, 29 Oct 2023 21:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698638620; x=1699243420;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dLeJj2kjjvnHF9poYPdAe1H0XDWnpt37eiZQMCtuR0E=;
 b=ITYiNJMKpEIR44V5VYfIuEeZRmjwHiVcfvO7TsmjmbWWRJ7cZCF4UOIAtfJDKv59Yd
 36LpAbyf/4CI0ukbWoyAqhRkypBlgTAS+SGJX3Y4y7vIg4tUKbXn9G/EWpB6JAXTihnV
 hCF/nm7TtDuZHCLZ9W4/Yyoxq5tWpj5dbfEvv1s0Byb/D0K19KRlDlVKuA5TxeQHTAH4
 VjAqBj4b88gfWGxxToEpnT8oH7dHbW79R3TfBUlQR87fWmize+9AhZTzMmSgcNZRGdQj
 RNP5G88nTVHWBrV/pbLwACBgpMNY+KuJvYh2AdUoCJJDE6bXzsTJqngw/RM4XHkfXsgr
 obsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698638620; x=1699243420;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dLeJj2kjjvnHF9poYPdAe1H0XDWnpt37eiZQMCtuR0E=;
 b=C2uNR4U5qCsJ/ihrVAZfD/2eDje76vfAOR7HfsC3xSf/P30uG81EVaaoUSH+Xmu+4O
 /+V01KNiqVh8/UmmNp3AnNOTT0kOtVYYH8aeHm8tHb15JrwbhKdJHCAk1IrZSnVNBtjy
 Jhxu1Vfqu5JMQxQ0/4irMlEOGeoZUwkQvRO3zzZCfykChH5bjawXL8q70eqhcdd1zHUh
 ysBSHufLoo6hFNlwuxuOfAmq2HKGOIeduoF2kQJXp1P31tEywLQpCR+VDvolhOCc0N9B
 1bcnQYS79m6fGfBTw3Kka7OQwcjD5FnyGlq1Vl1aVtAv79Grfmfv5hlmyQWvU7suNAaB
 CcBQ==
X-Gm-Message-State: AOJu0YwUqmc1hAAoIpE+GmS/kORkv2T8TTujsEkS40kldFE9tqvBRc+v
 4r8voey+YOsCtxTylNsD7Hrh5g==
X-Google-Smtp-Source: AGHT+IFyMGxaEXtxUAupXcS3sCO2rlEUzqUSnSePNAlN4meajG6kaB9AXGzJUPWWfLTajwqOFnRAVA==
X-Received: by 2002:a05:6a20:6a11:b0:17e:466:ea62 with SMTP id
 p17-20020a056a206a1100b0017e0466ea62mr8074353pzk.42.1698638620153; 
 Sun, 29 Oct 2023 21:03:40 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 gt1-20020a17090af2c100b0026b3f76a063sm4495612pjb.44.2023.10.29.21.03.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Oct 2023 21:03:39 -0700 (PDT)
Message-ID: <13dc8043-cf30-4fe7-9e1d-1c69f4e26b1a@daynix.com>
Date: Mon, 30 Oct 2023 13:03:37 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 04/21] net: Remove receive_raw()
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Andrew Melnychenko <andrew@daynix.com>, "Michael S . Tsirkin"
 <mst@redhat.com>
References: <20231017040932.62997-1-akihiko.odaki@daynix.com>
 <20231017040932.62997-5-akihiko.odaki@daynix.com>
 <CACGkMEukvjmJ20pWSDsxtxo_UZAC33yEjWNsSqdNJRm8xL2O4w@mail.gmail.com>
 <ef82309f-ca89-4850-acf6-94ffa7726c2f@daynix.com>
 <9204e711-0eb9-01da-54dd-c67ae9e05c3b@redhat.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <9204e711-0eb9-01da-54dd-c67ae9e05c3b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/30 12:06, Jason Wang wrote:
> 
> 在 2023/10/27 15:52, Akihiko Odaki 写道:
>> On 2023/10/27 15:49, Jason Wang wrote:
>>> On Tue, Oct 17, 2023 at 12:09 PM Akihiko Odaki 
>>> <akihiko.odaki@daynix.com> wrote:
>>>>
>>>> While netmap implements virtio-net header, it does not implement
>>>> receive_raw().
>>>
>>> The only user for raw is the announcing. Netmap probably doesn't it 
>>> at all.
>>
>> In my understanding, the announcing *sends* a raw packet.
> 
> 
> It's send via NIC and receive by its peer which is the TAP
> 
> qemu_send_packet_raw() -> nc -> nc->peer -> peer->receive_raw()?
> 
> Anything I miss?

The problem is that the peer can be netmap and netmap also requires a 
virtio-net header.

Regards,
Akihiko Odaki

