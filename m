Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B1BE81F8A9
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 14:10:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIq8b-00049J-04; Thu, 28 Dec 2023 08:09:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIq8Y-00048q-R0
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 08:09:22 -0500
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rIq8X-0008HL-Ay
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 08:09:22 -0500
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-336c9acec03so2317551f8f.2
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 05:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703768959; x=1704373759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8r5QO+yOSJFSVT2FFKvdhn5mqz/SAZpx+1zWA8AhmNQ=;
 b=rSnuCBaOSwPyxm7Gmz+5nM11QOkZoatShW53JXJaSNQoAPD1MLtbeBJPwiOV1HQgco
 Z1iSou2Ak+7kaU+HWG9e69Qx6l/VZ0KXemgFRoBQL2eJ197veMtrFx64HzTgJSlzCLhk
 oIQZDWFHMJXk85o043b8OH0KaT+G2OPDay8gEevSvKRsyzvtv0cKXjzN2y06ynWhD7sH
 /pLaIa0ovLRqkgoJcvI0R+6HqsJ3sMq5naQsYPhUPx4iv9uUhhKu0JnMWzJZ+rHhrbUX
 6OiMDStKf0OQRwGQff7+6K7Vz68YYx3gQhbptJ+fBJxLtV5tQ4xPjoBIKazCXroPmdN3
 EFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703768959; x=1704373759;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8r5QO+yOSJFSVT2FFKvdhn5mqz/SAZpx+1zWA8AhmNQ=;
 b=pwkapRD6QP/wW/CSo6R9D5wHbphsu3jrrmpnquYyYEW7ijjK2Ra/FNNCwp81YfjRuT
 a9QRxm1PZOhk3dvO2jrU/8k4e674etNIu+0r/M0Dh+4lNWlXAyr8dafsxC6cj4HCeftI
 2XSwNiZJYC6YwSMgZLY1KfdvNtp1SfbK/Fqlpb3Ghn4kwOYq3VLchtqqdCp9SASViCn7
 C6JbfSRGfMAPehgZ9FAVPryVzydsh/7MH2edTj9IXeAgN9u5Zkx7k3xSys/OCx2FGNix
 eraLe2VogD4v1lKyQNtwhWuEQO1PSzltBmk+2nfRfsEx0hGxGb6s63sT935tXDHEj5TP
 WQsQ==
X-Gm-Message-State: AOJu0Yyj0XlpxjJd89kUB08UtzYM7Pc8PUIbLAoOwf84amPO9DA9e59M
 U1LO9nn+1wfyk+9t6p15+4yol3pEMl5W6Q==
X-Google-Smtp-Source: AGHT+IG+YAruasn9L2SNZrRTE8Ns/HdvkNqgJVEdA3+HVps3YNRdmfxzbHioRvgdUfCWtwEICsUltg==
X-Received: by 2002:a5d:49c7:0:b0:333:2fd2:68ec with SMTP id
 t7-20020a5d49c7000000b003332fd268ecmr4531125wrs.127.1703768959471; 
 Thu, 28 Dec 2023 05:09:19 -0800 (PST)
Received: from [192.168.69.100] (roo49-h02-176-184-1-50.dsl.sta.abo.bbox.fr.
 [176.184.1.50]) by smtp.gmail.com with ESMTPSA id
 z16-20020adfec90000000b003366fb71297sm16953361wrn.81.2023.12.28.05.09.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Dec 2023 05:09:19 -0800 (PST)
Message-ID: <ed169305-b20a-4cbd-a242-202df8bd05a8@linaro.org>
Date: Thu, 28 Dec 2023 14:09:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] meson.build: report graphics backends
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20231228113335.63354-2-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231228113335.63354-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 28/12/23 12:33, Paolo Bonzini wrote:
> Queued with the duplication removed, thanks.

Thanks!


