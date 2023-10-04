Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA1F7B8032
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:05:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1Xx-0001RD-3y; Wed, 04 Oct 2023 09:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo1Xv-0001R0-HW
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:04:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo1Xu-0005yG-4V
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696424649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D1EiTpLeGcKJPVJ8XPKLqPNau5gg28GmfPqDjf9inu4=;
 b=O/cvsoB8oKlPNChpLZmgG8NoHMVsGdfnBhsx3b4LrdIswBDtb6k6/q4jwRy9A19Rw11HMG
 G/y1l40fS/ARunGXGHpJYw1/xYOBXzhqx9lkXEXehcx3nwmtZViMH4CGVd+hLDy8AUYRh5
 rYvRg3+MlC0p92H7owYt4yyf7F1Nvhk=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-9Op31unSO2uwthCVnrOZ6w-1; Wed, 04 Oct 2023 09:03:56 -0400
X-MC-Unique: 9Op31unSO2uwthCVnrOZ6w-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65b14f88921so21476586d6.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 06:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696424636; x=1697029436;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D1EiTpLeGcKJPVJ8XPKLqPNau5gg28GmfPqDjf9inu4=;
 b=MGvOlmOJ89rxMh6rEm1aWR74tLDz+cndFKOsX8GL9oM8flxOXxm0XU3LjEh5obdKMT
 T2G+w3GpwP1qWxQge0Lx5XLxhogQ2czZ0byAGUpu7nnsIIcFviYyJfAwFSt8oe2i2vzw
 xsqzQmeMFodwo6D61Mlc2mpI8W4sPEotifQe9Oc7d0tCa9Z4hN8aMfbgEnAQWvhvkOau
 ECen7bHzy7i+Pd1/FFI0tCt32KI2IXefZRL7qUCjCmqtYHZzHNddflL3kP/gm6+VUgpL
 91NaICx54byuxpZ3/eeZMC+Nhw97M+lAw4nrHyq8EoWC8B4KJJtNb4UQOPryxbfjcrdY
 HjPQ==
X-Gm-Message-State: AOJu0Yw9r5kTdaqtfwXaYJG6xIf0LwPlHDSj2P/yEwUwMeNYVp1/yEjJ
 DibUF1uHxDJ61XI+ZDuo/noCOtfkz6tn83vKoTttg4h5Ce+fcJYQn0tIROPW4A4q8JvoAopJOD2
 3ueiQTspsO6+hz6A=
X-Received: by 2002:a05:6214:16d1:b0:658:9cd9:ec64 with SMTP id
 d17-20020a05621416d100b006589cd9ec64mr2123237qvz.54.1696424636087; 
 Wed, 04 Oct 2023 06:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqvIczrR/NwleOKhY8HVZDAnbHUKS1NIbUoX1IQ9Qj+AEybyZ6W0KUIrB58TtTYg7odLpX2A==
X-Received: by 2002:a05:6214:16d1:b0:658:9cd9:ec64 with SMTP id
 d17-20020a05621416d100b006589cd9ec64mr2123220qvz.54.1696424635834; 
 Wed, 04 Oct 2023 06:03:55 -0700 (PDT)
Received: from [10.33.192.181] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a0cdd0c000000b0062ffbf23c22sm1301416qvk.131.2023.10.04.06.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 06:03:55 -0700 (PDT)
Message-ID: <8cc80be6-4bf3-e5fd-9b2c-c2961905cdef@redhat.com>
Date: Wed, 4 Oct 2023 15:03:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] hw/usb: Silence compiler warnings in USB code when
 compiling with -Wshadow
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-trivial@nongnu.org
References: <20231004093620.97906-1-thuth@redhat.com>
 <8734yqfw85.fsf@pond.sub.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <8734yqfw85.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 04/10/2023 13.44, Markus Armbruster wrote:
> I got one more:
> 
> ../hw/usb/host-libusb.c: In function ‘usb_host_open’:
> ../hw/usb/host-libusb.c:1013:13: warning: declaration of ‘rc’ shadows a previous local [-Wshadow=compatible-local]
>   1013 |         int rc = ioctl(hostfd, USBDEVFS_GET_SPEED, NULL);
>        |             ^~
> ../hw/usb/host-libusb.c:954:9: note: shadowed declaration is here
>    954 |     int rc;
>        |         ^~
> 

Drat, I missed that indeed. I'll send a v2.

  Thomas


