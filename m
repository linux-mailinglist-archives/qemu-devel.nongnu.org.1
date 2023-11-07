Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AE29B7E3855
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 10:57:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Ipw-0003Ea-A3; Tue, 07 Nov 2023 04:57:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0Ips-0003EA-Ur
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:57:29 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0Ipr-00081f-CZ
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 04:57:28 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9be02fcf268so805237766b.3
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 01:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699351046; x=1699955846; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wdID2S0/csG99H3+OG6PXNGBtZ0kwV9VWvjw+5q4hTw=;
 b=PddU94jxCWOl7f3eO6cQvLdieZtfASnt9XZTHIrcrLb1SrYQdsMH1wdVq39ZQiJm4D
 4JQlGH8+pQJvBfT78Mc3w0ZPAXIiCSj3QU9Vvio5GqgV56Fcs4rdYr+XkYgioEhTyCFh
 ndRljKQGwp9a+vA9086H10SgLj+cTCnAaNWXVVXF2UpLUcMKByqQlOOKg3bcU0MP6qvy
 +GJUfZLCegyq/iCyLgjrZ0h3ZUBJLBA+7JZ1fBSXMLZpXWujHm//RVTNDC8ul1cnXM3h
 Y/3CuVwrkOj4cPqvONPoHTaxBQ59z23iZjBbt8xC9iW1agu6szAdOZ8ZR/lAS2dKlvME
 uxag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699351046; x=1699955846;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wdID2S0/csG99H3+OG6PXNGBtZ0kwV9VWvjw+5q4hTw=;
 b=TSgqPhJKEWkQ9D+qqXV4q4+n9LmGcXhDbDcpumRB5o6Qeys9vDYhYa7WFXs9pP6U83
 LGki/XaDI+kh12gn71JyElfBqDtyfPYuuAAMK7zsPyKoJN1jAfqTKZJfjF7PjKjBmWEx
 5tjdKobGbQpvZlBFD8zjDlXcSthsrovMnD4ixbk2Mp5YAFULw/LsYdDBzx42WkuJi4bN
 iNxjoJjOotaJUAwX/p78rdtROr8BIK8FC9gv3USAU4LLvuGqsssJ9UDZDZf6xf0tFK0u
 a8dBN3vZeRUI32kXQ0xANJr20cweR/m4J+iAZIoQj/h5UJwRliZR382hHKKvViKV2ILQ
 w6nQ==
X-Gm-Message-State: AOJu0Ywc6FOKjbsX6Rimo6ucOEnYw6kC4mSN/0l7I/ohbs++ujs9r8nG
 wctPJk1r9FFto6QY2Ae308HwbQ==
X-Google-Smtp-Source: AGHT+IFz2pG6m94zv0R4QF9WGmbDxiFDhI7udBlWe0tag+qCVUt7W3MFDk4Vgte04nPCpVajxg60Ng==
X-Received: by 2002:a17:907:3ea7:b0:9d3:afe1:b3e5 with SMTP id
 hs39-20020a1709073ea700b009d3afe1b3e5mr15862154ejc.75.1699351045874; 
 Tue, 07 Nov 2023 01:57:25 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a170906c18b00b009dfd472544esm861717ejz.17.2023.11.07.01.57.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 01:57:25 -0800 (PST)
Message-ID: <677fe308-5dc2-43d8-8ca4-114c528d0823@linaro.org>
Date: Tue, 7 Nov 2023 10:57:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] dynamic timeout for tests
Content-Language: en-US
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <cover.1699349799.git.mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <cover.1699349799.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

Hi Michael,

On 7/11/23 10:49, Michael S. Tsirkin wrote:
> so we keep making timeouts longer for CI but one has to stop
> somewhere. netdev socket test recently failed for me again
> even though it's at 2 minutes already.
> here's an experiment for netdev-socket.
> if this works well for a while we can generalize to other
> tests.
> 
> Michael S. Tsirkin (2):
>    osdep: add getloadavg
>    netdev: set timeout depending on loadavg

The 2 problems I see with this approach are:

- Machine load can vary *after* the test is started,
- Test environment isn't really reproducible.

Are those netdev tests only failing due to high load?

Maybe we need to disable them on CI and run them manually...

Regards,

Phil.

