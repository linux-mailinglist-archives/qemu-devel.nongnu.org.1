Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 08011927578
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jul 2024 13:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPKxN-0002zT-BR; Thu, 04 Jul 2024 07:48:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sPKxF-0002z1-Ow
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:48:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sPKxA-0000m9-Se
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 07:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720093723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=wbnzEb95xqpOM6pTDVI5AD87mXajYOGOfP+VPhuNCZQ=;
 b=RXLkXo+N3nDtlnydFzkSSzY3D+duwDLUNAaFrYMi9pokzpGriuomTZRawB5i/ideLUZrov
 Jf9aTZXbXxUs71NedQs/MyHge2JmwIb3DJFzewTRoMKoL65cBsgCP0MQAfDigp6WJilAV3
 PninwLIcQVVS8ucOHha+VNGkHrifsHE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-tDUz1uM4OQuGMM7weJEQUw-1; Thu, 04 Jul 2024 07:48:42 -0400
X-MC-Unique: tDUz1uM4OQuGMM7weJEQUw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-36796a0687bso500446f8f.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 04:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720093721; x=1720698521;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wbnzEb95xqpOM6pTDVI5AD87mXajYOGOfP+VPhuNCZQ=;
 b=Nj3iuHEUeEHO3UfC5zmBnyA3wYbax7JDBQVYmCiv4HbeNSV9fM77VzhWXbZzbFxbyc
 CtVOFdewzqznmZ3dqi0wrRScezPuuvl1E6a8/n/+EfRWoMCMtof9Ec2q+9zZi9yLiPDj
 9udQGuYeXIU5cMx42idYVOtDWigfbor+YLSRjQsTdn0RY8Nyl29aFg80psgrSbw/C0PO
 hCt1zqgNajXLFZRMAnhxCV7Fu/xiNm+olyingFuQxtUvScBVagViGdic/YM5UE2sYwDa
 3NXaNL8LiUmBCAMJc2wExn9NrCPpuYgUjx9SFmE87P5hAULdG5KPfZkxZXm3ABsuungj
 wNlg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjzWC/t7rSr00T51yFsrjVBRE/YIOL7B7fpwZx586UWECGyVBA05l/FuKdpc8UjfWh593yRWdoL5fFBrjG/YVg8bVc+PQ=
X-Gm-Message-State: AOJu0Yz5gcNNlUDedIjMrLDfdao93564lJKfZaZ6aeV0Uqv+yVqZQZgc
 MooWDH3U44Eh607nr/Y+tuhWxYo1cNLneaiIum4QYsPg7KXfjRJQNYIokf7xmxsC5/Vr63oSZ8f
 ZdcOeN3ofrvG4VyqS9ovC/6bTpXoKL5mIyh8nfmiYqCInXrUguy8M
X-Received: by 2002:adf:e68b:0:b0:360:791c:aff2 with SMTP id
 ffacd0b85a97d-3679dd66a54mr994215f8f.47.1720093720892; 
 Thu, 04 Jul 2024 04:48:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVpHWklQ0YSlJr59kKo3eI5IhBZ7DiQzDiwZU1SOPy6cPNlE9e3q25cpazsoS588ZaVaHITw==
X-Received: by 2002:adf:e68b:0:b0:360:791c:aff2 with SMTP id
 ffacd0b85a97d-3679dd66a54mr994202f8f.47.1720093720569; 
 Thu, 04 Jul 2024 04:48:40 -0700 (PDT)
Received: from [192.168.0.4] (ip-109-42-179-211.web.vodafone.de.
 [109.42.179.211]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-367a29eab73sm431506f8f.41.2024.07.04.04.48.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 04:48:40 -0700 (PDT)
Message-ID: <db14e63e-3a86-4173-b4f6-cd469a511f10@redhat.com>
Date: Thu, 4 Jul 2024 13:48:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 02/12] tests/qtest/migration-test: enable on s390x with TCG
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Prasad Pandit <pjp@fedoraproject.org>
References: <20240702103310.347201-1-thuth@redhat.com>
 <20240702103310.347201-3-thuth@redhat.com>
 <D2GPQVG9Q7RY.1HUJR9EC96HWC@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <D2GPQVG9Q7RY.1HUJR9EC96HWC@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 04/07/2024 13.20, Nicholas Piggin wrote:
> On Tue Jul 2, 2024 at 8:33 PM AEST, Thomas Huth wrote:
>> From: Nicholas Piggin <npiggin@gmail.com>
>>
>> s390x with TCG is more stable now. Enable it.
> 
> Ah, you did a more complete version of my flic fix that migrates all the
> state. I didn't see that go by but yeah I suspect that was probably the
> correct thing to do. Thanks for that.

Drat, seems like I forgot to CC: you on that patch, sorry for that, that was 
by accident and certainly not on purpose :-(

> Should the s390x flic migrate fix could be got to stable, perhaps?

We need a new machine type for enabling the fix, so it does not make much 
sense on stable, unfortunately.

> There's some kvm-unit-tests s390x migration tests that can be enabled
> after the fix too don't forget.

Right, I'll try to remember to enable it once QEMU 9.1 has been released.

  Thomas


