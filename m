Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6CC7F2CEA
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 13:17:09 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5PgK-0004Oo-2p; Tue, 21 Nov 2023 07:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5Pfv-0004LF-3V
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:16:22 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1r5Pfs-0002nv-40
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 07:16:17 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32d9effe314so3881002f8f.3
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 04:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700568974; x=1701173774; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JDxv8dF0rBA/MejO/JqkJYni6H0QlKaA2vRRm7RNVKs=;
 b=xuUUQ8mOYbccJQH5xD4XXvcC3Kh0wow4/fqAyxr5kfjj71FDo2rCRyRNJb2lsBqL2P
 quTSwRP5bU17vMoW7fi8yp/z/N5cAj6fqpkbVb64s0OR+wBt64AwXzzh9yvLHgXMLEXO
 +nrA7cm4CUYvTKhikDuyvOnWUHnXoG/peBia3Ctj8sSs+AAnPdbwTbKvtc0yH0Oaydqs
 QrLhDOX7Cb/a4Znm8xyaSGr5rTblPD219obRidwIS7VIJJsDF+RqnoRjnPvd+Pbz16+o
 jr8Y8x0yfnSJywpegVGCVDkXNbHP+ZH8NBsB5s3e+RX04y5p961ZMdkkmdSv6UDS3QSM
 QgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700568974; x=1701173774;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JDxv8dF0rBA/MejO/JqkJYni6H0QlKaA2vRRm7RNVKs=;
 b=YKTZE9EpiyjO9Vzz9gmBxskIyd6hDHOTteJXvb8ByxveB6qfPNrRtQI4ZyIvcll9Lf
 RFsJgSQCZ2qrMS7kxTR9nfnHmzOzpRNfaFZ5P5Df/ZfJUo+iwv/W2YrPlBnb6kkrss92
 Bq9S6dRZcCD98P9/KJD9mZR+NxgIhNHaQ0ksm4ICGfFuIZguivGGDkXOvWb8rusFWjMh
 o6FsWBBT0T3zE8karu0eHlbjmqjZmRXLOIIPuh/qFqQBs4XaXpY9RRWJAw3JHaCns5W3
 MhBAilINF/2v+Ko/0++Bl3i6X4mggfUAmrBkHxEJkHAq4ezq7to+NNTFnXdL8yjzhll+
 Y0Fg==
X-Gm-Message-State: AOJu0YxdZ6g8ECN6SCwqpqhywJNdRTNcLcb3iVvUAr0dojbR3NCBsAJ5
 wc+ZpWsR1zurTc5T6CVsEIBAxQ==
X-Google-Smtp-Source: AGHT+IEo66OzSMz75cGEWDDOQQBib2wgFNT4P9N+yPByJj4RI01PMn7m4n7K68Pn5iQpUwTFt3a/XA==
X-Received: by 2002:adf:fec5:0:b0:332:cddc:24fb with SMTP id
 q5-20020adffec5000000b00332cddc24fbmr1510386wrs.26.1700568974435; 
 Tue, 21 Nov 2023 04:16:14 -0800 (PST)
Received: from meli.delivery (adsl-195.37.6.2.tellas.gr. [37.6.2.195])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a5d6a05000000b0032d2489a399sm14070970wru.49.2023.11.21.04.16.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 04:16:14 -0800 (PST)
Date: Tue, 21 Nov 2023 14:15:09 +0200
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-arm@nongnu.org,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 C=?UTF-8?B?w6k=?= dric Le Goater <clg@kaod.org>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH-for-9.0 07/25] memory: Have memory_region_init_rom()
 handler return a boolean
User-Agent: meli 0.8.2
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-8-philmd@linaro.org>
In-Reply-To: <20231120213301.24349-8-philmd@linaro.org>
Message-ID: <4h3f0.gab1yddmsk3r@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
>Following the example documented since commit e3fe3988d7 ("error:
>Document Error API usage rules"), have cpu_exec_realizefn()
>return a boolean indicating whether an error is set or not.
>
>Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>---
> include/exec/memory.h | 4 +++-

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

