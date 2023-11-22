Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B370A7F3F1B
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 08:44:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5htO-0007AM-L6; Wed, 22 Nov 2023 02:43:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5htM-00079k-Vw
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:43:25 -0500
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5htK-0003pe-GL
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 02:43:24 -0500
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2c5071165d5so80463011fa.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 23:43:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700639000; x=1701243800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=wdW9qcPlDU/+9o1J0Z3/UYDtxEMyX40Ti/pc/+pjnZI=;
 b=LhmpmRJGZmGuSb8VF0a5fGQSgx6G7PK1K16hmDqY1abPe6vDESgQtDRayuNP9Edf0O
 dyybwTmitq8eJ4tvdUyrAfs7A1DoxwiIv4ODdFhCzJcQQrWZY7VFF2DRQ2V7RsJ+hysP
 14r1ZKgKfDd+WbC0HZYBBiY/+2d6zWDg5OI5A3F2g26hIfWn9L1nZkVFS1MV+jDRAhao
 T71OrdUjyoPQEyWQjQP5KweKvaRqFZmWEtsozhdgrzRy9wRWl80DR1H+JbgVsj3Kn5cN
 hkmtezAyNMDUSyMjyqpf6uSUYHJvuUufDVH+u4CFhtcpQiW8bAW5vnKlchBj8b3mwrU9
 s3bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700639000; x=1701243800;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wdW9qcPlDU/+9o1J0Z3/UYDtxEMyX40Ti/pc/+pjnZI=;
 b=meU/HBNjTpe+znd7ONRVbRPN3DM9nm9XrX5HcXsZ6+Zcu/B9b7PNKCtfadyN7cbI47
 drW+h8+SWrFHQtUlsilQ+pw7IWwbCdVhuRniSAx2pT8neYsErSAUxHuf1rO8IXrNePuI
 V7j9fWWPnzrJ26qqUqT9f1tC/kP9p8LIFJKsSejCnW355g7AqWzV1d8iiCEK60KKhF6i
 NHFkNxO/18TaCxxbhNpJRusVk4j01FbMEqmnmuYiNIp1xRhUL1Ld6SiPWWELbTYU6M/N
 uOhrQBKR5IgUjbfbBryWapZADF1SMi8jpjAW8KMksSXquo0K10xht2+I1Sdw0Uwm2B+G
 UqAA==
X-Gm-Message-State: AOJu0YxN/ID2NZ0Sh8q5wW4T+j7uF+/1b5XWCCqc/qCZCYYmF5luLLLF
 m9JcbUpMEyViclj90VafuPq5F8fBd+oQ/ItU/W2O0w==
X-Google-Smtp-Source: AGHT+IF+6v7ErN8KB+OL6hvW5YqJSiJBlVkePC4lXkTIU7Z2rD2owswDxkeNwVx6om3mVW4BqvI5/A==
X-Received: by 2002:a05:651c:b2c:b0:2c0:2583:520e with SMTP id
 b44-20020a05651c0b2c00b002c02583520emr1268551ljr.41.1700638999942; 
 Tue, 21 Nov 2023 23:43:19 -0800 (PST)
Received: from meli.delivery (adsl-27.37.6.163.tellas.gr. [37.6.163.27])
 by smtp.gmail.com with ESMTPSA id
 j19-20020a05600c1c1300b0040b2b412a0dsm1242710wms.7.2023.11.21.23.43.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 23:43:19 -0800 (PST)
Date: Wed, 22 Nov 2023 09:42:01 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@kaod.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Jean-Christophe Dubois <jcd@tribudubois.net>,
 Herv=?UTF-8?B?w6kg?=Poussineau <hpoussin@reactos.org>
Subject: Re: [PATCH-for-9.0 20/25] hw: Simplify memory_region_init_ram() calls
User-Agent: meli 0.8.2
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-21-philmd@linaro.org>
In-Reply-To: <20231120213301.24349-21-philmd@linaro.org>
Message-ID: <4ilg5.a7wcjg47v90i@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 20 Nov 2023 23:32, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>Mechanical change using the following coccinelle script:
>
>@@
>expression mr, owner, arg3, arg4, errp;
>@@
>-   memory_region_init_ram(mr, owner, arg3, arg4, &errp);
>    if (
>-       errp
>+       !memory_region_init_ram(mr, owner, arg3, arg4, &errp)
>    ) {
>        ...
>        return;
>    }
>
>and removing the local Error variable.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>



