Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 059417BF786
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 11:39:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq9CY-0000hs-SR; Tue, 10 Oct 2023 05:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq9CE-0000c1-H6
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:38:34 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qq9C9-0001cF-4j
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:38:31 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-694f3444f94so4442674b3a.2
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 02:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1696930705; x=1697535505;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HoAO4MU3+HX/pu5nZVUw6NryiBkQ92zJRW3EbT9zs2M=;
 b=b3j/fYn/TdQPraqhdTqXTZ1As8rgOVPc8fGQ/vsM1lT38dJJ/0oq7nIrM3BHUI7TXE
 PiDYdk3V7a/vvih82I+zMEUiFBFKacqywpjJKNk6+o8yNmBVM/3mrfheazA7n0nXdAxH
 0YgjWTjmyfenD5SGd8vpaOcO2heuCGdWyuQP5jCz3hTFZ5Cw746lk7iiynuQEpHQXlYD
 SNg17wtPsPyNp7QWtqhO3GWss14ntwkVg67MGqK7s5rAVQRR6I7Qnz+JAOCvaKXS967U
 E6vXKvUqLWxGjZ8rYtWNo9dvb+VU8JqPOO3sl5vNDYk3GKadzVLZ346OmBu1MdQFBVB/
 2ftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696930705; x=1697535505;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HoAO4MU3+HX/pu5nZVUw6NryiBkQ92zJRW3EbT9zs2M=;
 b=iFpK06HlyM4a9j4qhtLzdzeAH/aywyn+Hs3XWY9YE0BbTQCvXKlJpHLWNJq/dWAWqI
 PVTwd9q4qjn3hA6dN3oI7q/W/a5h7UxLY4j+5HMBgGloEc/TVTVEujV0STMl1We1dhxn
 HlUC8NyIsKIaPO3mitJZBUQPcANg9B9K2Y8f77BGqFzCqMU9s2Cm3Qmvu8Mk5hqBq3Uw
 wpyaj+4PLGVSrCLcCvjxulTVDItDbJLM8VHbV6tjVE0REN/PF845x+CwdEKHRC3Zh9m8
 /DrewFj+fHH2LGsugklJ2tAdOYi+NMfCNCW9LRLrwmhodVTL4jUCYyL4jXIK3i1VP1dx
 i54Q==
X-Gm-Message-State: AOJu0YyVZTTbAmk6lI7XpYouv/YDhL5pG4DIs70ieXSVqN7Gzzrtn4LC
 IBMFOlzFD4dQrNy0f2JlF9kkTw==
X-Google-Smtp-Source: AGHT+IFLaMgQENjLvJkfk7pzKNhxG7HGIKa0urAQS112N7v4/1GLtegSoR+l/iVqe08cbr+zzgP60w==
X-Received: by 2002:a05:6a20:ce8f:b0:152:cb38:5b47 with SMTP id
 if15-20020a056a20ce8f00b00152cb385b47mr17028892pzb.55.1696930705544; 
 Tue, 10 Oct 2023 02:38:25 -0700 (PDT)
Received: from [157.82.206.10] ([157.82.206.10])
 by smtp.gmail.com with ESMTPSA id
 it9-20020a056a00458900b0069346777241sm8066145pfb.97.2023.10.10.02.38.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 02:38:24 -0700 (PDT)
Message-ID: <ab7ffc78-fe3d-4e99-b3c6-e66f7b0c7e18@daynix.com>
Date: Tue, 10 Oct 2023 18:38:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tests/qtest: Use qtest_get_base_arch()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-ppc@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Fam Zheng <fam@euphon.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Alexander Bulekov <alxndr@bu.edu>,
 Bandan Das <bsd@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Darren Kenny <darren.kenny@oracle.com>, Qiuhao Li <Qiuhao.Li@outlook.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Jeuk Kim
 <jeuk20.kim@samsung.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Amit Shah <amit@kernel.org>
References: <20231010074952.79165-1-philmd@linaro.org>
 <20231010074952.79165-5-philmd@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231010074952.79165-5-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

On 2023/10/10 16:49, Philippe Mathieu-Daudé wrote:
> Additionally use qtest_get_arch_bits() when relevant.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

