Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF0897E66DF
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 10:33:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r11PE-0003NH-IT; Thu, 09 Nov 2023 04:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r11PB-0003N7-V1
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:32:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r11PA-00054Y-3e
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 04:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699522370;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rji8ECOY6YoKqTuQtXLqp2YvEuGMO0YMzZXs7hjKbfo=;
 b=f0yReA8xZiFZrSzvBeYAFDTam66mbUJ6DuyrKAegDkFS+gYehyfMf1ntuXhMAshX2wUagz
 qFSsibX9mj96odUHNr74k/ibeh+WNtdL+EibQJoAA3OyiMXQZFcA43Bm2micRWZqRn0ySE
 FnCLBIYHonMD99pBbUXu0duppnLoOng=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-MpoRKpohMXyUIKnGzNJSzA-1; Thu, 09 Nov 2023 04:32:48 -0500
X-MC-Unique: MpoRKpohMXyUIKnGzNJSzA-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9e304dd4856so53421966b.0
 for <qemu-devel@nongnu.org>; Thu, 09 Nov 2023 01:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699522367; x=1700127167;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rji8ECOY6YoKqTuQtXLqp2YvEuGMO0YMzZXs7hjKbfo=;
 b=ay9WAZXOqRE259rQOZgidnVGvfgc5TLYUAXAqz124k4/c01rPxp45UTC8nVrslIrHs
 tu0EehRuT+mfKgx8E2EqGBlzZi0nxrxpjwVyl9vvbdcVBlimXhuWU9O/bX29U3WULHet
 qYRLqZYhUfUXr4MZfQtCVWRFo9IP75Ec14qwiK/mObCCGthQM2cH+owezDgtB8lIUUpx
 4/kztWl77Vs4saYZreQKE6RthG5nbGZ0u28fmrfTNCZwZlztB2xqGAiRD++V8OdcbOEG
 BQ0SVCuXCgmAoktwO1VgEjsSDumBfbjaQxMzWPJkCItOuK3DJk5xUdOjtLLnpYB68r3G
 Dvcg==
X-Gm-Message-State: AOJu0YyfgW6HolkE7aUqiBe74CN0e6+tieBG8jLLAWldn6V9js2XyL/+
 KvFpjK1NoXXriJGKdK24uvEckb6nruWlC40bogskvan3dSJpCLWrq3418pXl1hBIjNfZ/GV97Uk
 NHR5zgBvpMK6hdlZ4aYHxhFM=
X-Received: by 2002:a17:907:72d4:b0:9bf:5696:9153 with SMTP id
 du20-20020a17090772d400b009bf56969153mr4085318ejc.57.1699522366781; 
 Thu, 09 Nov 2023 01:32:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEUY50cxg3JIihk2d7AiS3iUEiYJyZKcv9NR3J2cErDiciV13XT68LeNJjk+Z2ZilyvCqk23Q==
X-Received: by 2002:a17:907:72d4:b0:9bf:5696:9153 with SMTP id
 du20-20020a17090772d400b009bf56969153mr4085309ejc.57.1699522366454; 
 Thu, 09 Nov 2023 01:32:46 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 v20-20020a17090606d400b009930042510csm2308474ejb.222.2023.11.09.01.32.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Nov 2023 01:32:45 -0800 (PST)
Message-ID: <edbf6575-08cf-49a5-8ac9-caf65d90c63a@redhat.com>
Date: Thu, 9 Nov 2023 10:32:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] plugins: fix win plugin tests on cross compile
Content-Language: en-US
To: Greg Manning <gmanning@rapitasystems.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20231109092418.84-1-gmanning@rapitasystems.com>
 <20231109092418.84-2-gmanning@rapitasystems.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20231109092418.84-2-gmanning@rapitasystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/9/23 10:24, Greg Manning wrote:
>        t += shared_module(i, files(i + '.c') + '../../contrib/plugins/win32_linker.c',
>                          include_directories: '../../include/qemu',
> -                        objects: [win32_qemu_plugin_api_lib],
> +                        link_depends: [win32_qemu_plugin_api_lib],
> +                        link_args: ['-Lplugins', '-lqemu_plugin_api'],
>                          dependencies: glib)

Does it work if you use win32_qemu_plugin_api_lib.full_path() for the 
link_args?  (If so it can be fixed when applying).

Paolo


