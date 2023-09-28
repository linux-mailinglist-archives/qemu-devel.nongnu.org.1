Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 063197B231E
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Sep 2023 19:03:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qluPF-0005bP-RT; Thu, 28 Sep 2023 13:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qluOc-0005Us-CK
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 13:02:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qluOZ-0005VC-Gy
 for qemu-devel@nongnu.org; Thu, 28 Sep 2023 13:01:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695920505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X/mnsyJwT3fSoiZE3m6DmMuOOcFAZUXsDUMfH0x0kQ0=;
 b=iKZQeSTbA0XIGLVvkFX5vwwhtnp9Oq6ycv88/WoBkMy+EVfW1CiuSKrXVXKU/3HmSQEEH9
 5Q1Lt2WgDD5xeCM7rOJ4WtBW1etRxEnnK6alam8hbNY3pkND6OVP5t60oIdcIGSN9p7Xgl
 1FQlvzUIiXENH26KdVEfumyRW08ICSw=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-26yco50QPLGwdInuxE9deg-1; Thu, 28 Sep 2023 13:01:41 -0400
X-MC-Unique: 26yco50QPLGwdInuxE9deg-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7740bc7ad68so2619813985a.2
 for <qemu-devel@nongnu.org>; Thu, 28 Sep 2023 10:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695920501; x=1696525301;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X/mnsyJwT3fSoiZE3m6DmMuOOcFAZUXsDUMfH0x0kQ0=;
 b=tSqzhg6fGhdjI/Dqm0Jnmtt5KmaTt714waOnRe1MBw0EIq28LLz74T0yMUN6QtYuOO
 YmPTOfKKnRfaBlkTQZ9lEBB7+OvnV0GITvJhFaMbII82okjsbolzUpz1oVgA1wn5gy5o
 0Gg2wp+kOl4V1wLRrD+I+c0adQ8hFv19h+VIrY/NEbmEw92dShravfyeXOzwMzV/sK41
 a1NiN1yhanC/HzcDcvd9Bol7ahrVGHgc13LnYDwrGv8ejiD8DgPcAAX4JtczxFNLwx/k
 xKklDGrhlOxMgj1o9Gf+BJqpEdzbgdXbxgGzVhff7v7Y84dms/42TPrbfiRopFl9yS/q
 fP6A==
X-Gm-Message-State: AOJu0Yyf/PqEB8bJBzwdl2meAPnw1aTjXOFSG9Bx+cH7LngGTft20xLQ
 2pGPjRfCCOEIpn8FeElZqVPk+d1gdJjSoBU+CHsCXLPvqjWByG7UoBKIv95kfpXNrErJTmCiuUp
 Bt0fZ51gDpf2JZkg=
X-Received: by 2002:a05:620a:4042:b0:767:9d40:a3b7 with SMTP id
 i2-20020a05620a404200b007679d40a3b7mr1782309qko.21.1695920501285; 
 Thu, 28 Sep 2023 10:01:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHf9G8gc5yi4uTpvkNz0KZe6lSZq79Tck5oONIoqCO0kb0xeZAwqYv81g4TbAsMVWWKhgbPYw==
X-Received: by 2002:a05:620a:4042:b0:767:9d40:a3b7 with SMTP id
 i2-20020a05620a404200b007679d40a3b7mr1782271qko.21.1695920500976; 
 Thu, 28 Sep 2023 10:01:40 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 m14-20020ae9e00e000000b007742ad3047asm4007485qkk.54.2023.09.28.10.01.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Sep 2023 10:01:40 -0700 (PDT)
Message-ID: <d599c25d-2a9e-32a0-5a5d-f67adfcf5eed@redhat.com>
Date: Thu, 28 Sep 2023 19:01:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: confirming the patch is a solution
Content-Language: en-US
To: recallmenot <edmund.raile@proton.me>
Cc: alex.williamson@redhat.com, dongwon.kim@intel.com, kraxel@redhat.com,
 marcandre.lureau@gmail.com, mjt@tls.msk.ru, mst@redhat.com,
 philmd@linaro.org, qemu-devel@nongnu.org
References: <20230928164622.787298-1-edmund.raile@proton.me>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230928164622.787298-1-edmund.raile@proton.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

Hello Edmund,

On 9/28/23 18:46, recallmenot wrote:
> Hi,
> I can confirm the patch fixes issue 1891 for GVT-g + DMABUF + GTK UI.
> 
> I'd say having a display is -inf % better than a black screen.
> 
> Haven't heard / seen anything from Gerd in a long while, hope he's doing well.
> 
> Kind regards,
> Edmund Raile.

If you could reply to this email :

   https://lore.kernel.org/qemu-devel/20230816215550.1723696-1-alex.williamson@redhat.com/

with a Tested-by: <email>

That would be great !

Any how, thanks for the feedback and the test.

C.


