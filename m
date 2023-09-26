Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 960197AEF30
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 17:07:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql9ef-00055H-BZ; Tue, 26 Sep 2023 11:07:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ql9eR-00052W-LC
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:07:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1ql9eM-0003HW-RK
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 11:07:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695740817;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e3vjynd3HjjoyrT8xdu7gF7+aWjEJ1r/2W3goXO8M5s=;
 b=ATSpKTu7etEt11tn3Og7gVo8yf66uf6Ze0rCyjN0o0m7JXmWHoEd2ita/7h/Xet4KhvUCD
 xsM/teO14M/c4bAJpQ+/WH7IwLvho6ltsUOI6RYDD82s+YmqQcZMlhG0KGyUKVtGQOiMjM
 SVndUknsgjuCusoTYpOBVTrojmWFS5Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-gDo0FBvMNN2BwgNegICwCQ-1; Tue, 26 Sep 2023 11:06:55 -0400
X-MC-Unique: gDo0FBvMNN2BwgNegICwCQ-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-774105f6fb1so1476725085a.3
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695740815; x=1696345615;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e3vjynd3HjjoyrT8xdu7gF7+aWjEJ1r/2W3goXO8M5s=;
 b=oj9Zk8CbPuEjpLgfBXuAzoSSPtM+SUkekWMf2AT9j0noNSPrMijvKECipYGN48Bs4N
 TA/40gMpxecQQyBbOkQ9rfuulwfOCC30VdcmHEzYYaHpN2WZY1YldBMdZylh+q+WxMbN
 Iu6B7pE0/LcpibsNXQ2kTuS0y8E/0KMsYMinQ1DYgKrxpHHLeAYqpLkeT+9ucEwIGSlL
 mNsvRJjvAMzMgzDb3blaxJgUvnjV8uY0lbLJeWkIhioHdU/ffD5UFtp8XV5SWn23EDxo
 uQmd4E3gcK4IyNghbkdbPCOB5TQhGfe3L/wgY+cyfsdq16hqD1ZUlJKPt7qcGQ4zQD+i
 +0rw==
X-Gm-Message-State: AOJu0Yy4zizEAczHQ/03NW0amhbUkyV1DRy67bhtY5T9p2eDxmP3eDWc
 TbAhg0x4QyeaqKbUbNvrfbkzD7BPrXu9LIkjxrc3b7yab1jPwQdpEjzpwj0DwgtBoeMj+h1qPuu
 08OkZL0yFWPks5eU=
X-Received: by 2002:a05:620a:4cf:b0:76f:456:3916 with SMTP id
 15-20020a05620a04cf00b0076f04563916mr9620174qks.43.1695740814821; 
 Tue, 26 Sep 2023 08:06:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQLzNUe0j2s+XQEVbiHsG9VlqvY8q0mVqoSAxbCZxFHehnllP5yklobnoTQSkZqIPpohR5Bg==
X-Received: by 2002:a05:620a:4cf:b0:76f:456:3916 with SMTP id
 15-20020a05620a04cf00b0076f04563916mr9620154qks.43.1695740814502; 
 Tue, 26 Sep 2023 08:06:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:59e:9d80:527b:9dff:feef:3874?
 ([2a01:e0a:59e:9d80:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 u6-20020a05622a010600b00403b44bc230sm4672594qtw.95.2023.09.26.08.06.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Sep 2023 08:06:53 -0700 (PDT)
Message-ID: <4c1f3eb7-8684-c883-ccdd-d3da17de03d6@redhat.com>
Date: Tue, 26 Sep 2023 17:06:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/4] hw/misc/arm_sysctl.c: Avoid shadowing local variable
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>
References: <20230922152944.3583438-1-peter.maydell@linaro.org>
 <20230922152944.3583438-3-peter.maydell@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20230922152944.3583438-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org



On 9/22/23 17:29, Peter Maydell wrote:
> Avoid shadowing a local variable in arm_sysctl_write():
>
> ../../hw/misc/arm_sysctl.c: In function ‘arm_sysctl_write’:
> ../../hw/misc/arm_sysctl.c:537:26: warning: declaration of ‘val’ shadows a parameter [-Wshadow=local]
>   537 |                 uint32_t val;
>       |                          ^~~
> ../../hw/misc/arm_sysctl.c:388:39: note: shadowed declaration is here
>   388 |                              uint64_t val, unsigned size)
>       |                              ~~~~~~~~~^~~
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/misc/arm_sysctl.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
> index 42d46938543..3e4f4b05244 100644
> --- a/hw/misc/arm_sysctl.c
> +++ b/hw/misc/arm_sysctl.c
> @@ -534,12 +534,12 @@ static void arm_sysctl_write(void *opaque, hwaddr offset,
>                      s->sys_cfgstat |= 2;        /* error */
>                  }
>              } else {
> -                uint32_t val;
> +                uint32_t data;
>                  if (!vexpress_cfgctrl_read(s, dcc, function, site, position,
> -                                           device, &val)) {
> +                                           device, &data)) {
>                      s->sys_cfgstat |= 2;        /* error */
>                  } else {
> -                    s->sys_cfgdata = val;
> +                    s->sys_cfgdata = data;
>                  }
>              }
>          }
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric


