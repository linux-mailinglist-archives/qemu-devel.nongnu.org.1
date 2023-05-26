Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E5671712035
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 08:38:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2R4m-00054e-KW; Fri, 26 May 2023 02:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2R4k-000542-99
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q2R4h-00030o-M0
 for qemu-devel@nongnu.org; Fri, 26 May 2023 02:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685083038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=93VbI4GHkUVZuRhRc6JcdsHOLPlm+XPnCsEV82LN6kg=;
 b=AcgYDtMwIf/J7h+GeSXy3CD/Vjm9z0pCejrWiRYNSpKgTfXZtuiVXqD93wJKrZCLIWX9tf
 K8GOtdN20sZj87aIPzexBK66XBWzZ8ICo/Sa5eTnsaHAp0xw1hV/Nizm0fMsR6G9NWgdGD
 cPvCabyd+xZrh3t+9tNvYoNz5VUiMiU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-IT3dasTiPM2eLX3okZcIyA-1; Fri, 26 May 2023 02:37:16 -0400
X-MC-Unique: IT3dasTiPM2eLX3okZcIyA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f604687a23so1948255e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 23:37:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685083035; x=1687675035;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=93VbI4GHkUVZuRhRc6JcdsHOLPlm+XPnCsEV82LN6kg=;
 b=hhqGRSK2+1wEBf9HKPYE+92xv4kEW5B/7FYlL0bOY+H2y52vCLAXpYqxYUjSOa4gRV
 J1V3OgKbQVG5le7X3RvIu5ceMY6d+b7NbdQYgx5NULbyy35ikE5PXbJae/70yD9sygBt
 26BGV5AGZlcu2xMnHhS8nboZLoBZW6/Sda4oa7Mp6iwtwC15BAkdzeDtyqE7pFMpekq5
 GRxe2NhibE/4OkAIopRBk6rayXKivIvKXmza8s+8958IyF30Oyb6WS8KAZ4hR2ChaAyM
 gUTw4BEGMuOo81TlkrFPniH0lSEK0XhY24Ha6Xl8jDJQ49Zcs+Kmbpjr7FolsjKTti/j
 KbOg==
X-Gm-Message-State: AC+VfDydqR4iogIUilVQPMlqGo/owU31xmfPGqcVqdosix6bkGk+5azq
 H72kPa91GHo/w8Y7sgs05xmrrN6OYNzqlxtiYseXHpGHtHBmlJoQIM7tfGbRpRxk7eEqJpBLmYV
 kHNJJmmVIPBN+Bwg=
X-Received: by 2002:a5d:638b:0:b0:307:7a73:bfa9 with SMTP id
 p11-20020a5d638b000000b003077a73bfa9mr550102wru.60.1685083035658; 
 Thu, 25 May 2023 23:37:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ56LFAm/JIHolv0y3raZNjxuLIPddj+KwoWXIqP7lNIRZrm+3VEru7WA0ETwIfIERhc9PYdEg==
X-Received: by 2002:a5d:638b:0:b0:307:7a73:bfa9 with SMTP id
 p11-20020a5d638b000000b003077a73bfa9mr550074wru.60.1685083035387; 
 Thu, 25 May 2023 23:37:15 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-189.web.vodafone.de.
 [109.43.176.189]) by smtp.gmail.com with ESMTPSA id
 e7-20020adfef07000000b003079ed1f0a0sm4016587wro.44.2023.05.25.23.37.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 23:37:14 -0700 (PDT)
Message-ID: <fbc8003d-9d91-55a0-940f-240d687aae75@redhat.com>
Date: Fri, 26 May 2023 08:37:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] hw/ufs: Initial commit for emulated
 Universal-Flash-Storage
Content-Language: en-US
To: jeuk20.kim@samsung.com, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 Klaus Birkelund Jensen <k.jensen@samsung.com>
References: <CGME20230526050555epcms2p287be772002cd941cc79226968c319036@epcms2p2>
 <20230526050555epcms2p287be772002cd941cc79226968c319036@epcms2p2>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230526050555epcms2p287be772002cd941cc79226968c319036@epcms2p2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 26/05/2023 07.05, Jeuk Kim wrote:
> Universal Flash Storage (UFS) is a high-performance mass storage device
> with a serial interface. It is primarily used as a high-performance
> data storage device for embedded applications.
> 
> This commit contains code for UFS device to be recognized
> as a UFS PCI device.
> Patches to handle UFS logical unit and Transfer Request will follow.
> 
> Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
> ---
>   MAINTAINERS              |    6 +
>   hw/Kconfig               |    1 +
>   hw/meson.build           |    1 +
>   hw/ufs/Kconfig           |    4 +
>   hw/ufs/meson.build       |    1 +
>   hw/ufs/trace-events      |   33 +
>   hw/ufs/trace.h           |    1 +
>   hw/ufs/ufs.c             |  305 ++++++++++
>   hw/ufs/ufs.h             |   42 ++
>   include/block/ufs.h      | 1251 ++++++++++++++++++++++++++++++++++++++
>   include/hw/pci/pci.h     |    1 +
>   include/hw/pci/pci_ids.h |    1 +
>   meson.build              |    1 +

Do you expect lots of additional files to be added to the hw/ufs/ folder? If 
the answer is no, then it's maybe a little bit overkill to introduce a 
separate folder for this. Wouldn't hw/block/ be a good fit for this as well? 
Or maybe we could introduce hw/flash/ or so and also move the contents of 
hw/nvme there?

  Thomas



