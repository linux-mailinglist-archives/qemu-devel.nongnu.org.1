Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A81DA86AEE4
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Feb 2024 13:13:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfIik-0000IY-Gb; Wed, 28 Feb 2024 07:07:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfIhm-0008CC-9T
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:06:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rfIhj-0004Gl-D3
 for qemu-devel@nongnu.org; Wed, 28 Feb 2024 07:06:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709121985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=BL/54CtAPj7J/HPpNmalyW6JbEk+lwX9pFy6xWP8SLQ=;
 b=SMBbKOg7V57m/jss4ul0Nso3nh+9JLHIPGIwwcJ92fm2k/HI3UbvrRSXhrpO0c9H3pzCa0
 s7MlcdAwlw/MAaXNYSWgyZQkcAHb5QMXx8jJPVPXRvlJ6a6VeYDkV9aR6Kx3ZslCCWYuOu
 hdyfrbjJA4lz2aQt3Sd3MOp/FsDJyOE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-DjgyDVORPia_IA43e4XrIw-1; Wed, 28 Feb 2024 07:06:24 -0500
X-MC-Unique: DjgyDVORPia_IA43e4XrIw-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-787c04e48a7so498842585a.1
 for <qemu-devel@nongnu.org>; Wed, 28 Feb 2024 04:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709121984; x=1709726784;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BL/54CtAPj7J/HPpNmalyW6JbEk+lwX9pFy6xWP8SLQ=;
 b=TQI6qVLJ/OJtd9apHRNVWNCJBf8sYPhENIaR2H7qE2nEMuZGlf5hZbOYnZkHV/CEni
 OM1H79FXSKt43FsglqLb+GIz/DYCG2FyCdwKGnJVzArP8IX+fel8Re1+a+w2MI7TdSvP
 5dDXvtUh0FsUgr280kNoDQZQv961bmXM97kw9nT2Eygza4AS2n1Pnp+U+B51l5TXNjQI
 m/NdFY4NmCFyeFi9G9vj5qlAZgUjOLRAXP6F8r1iJv4H1pLZQX+EOqYqcIr373D4QyLd
 9rmCuHtfzop3bzMUh197p829d1XzHaW3lN9aJbByRSYK7Wp3XcQReMF52AF09zCCd4Kb
 2oEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVhoK79sOEk5EgFShJVicpy4EAKlIWD/dpOjXVwR5vebPemiSNikGlspvSlfjQbnLZ+Ka0DbkhfpZgTNX4jLLeEvLOapOg=
X-Gm-Message-State: AOJu0YzUekrfUMk4b/kMB9b13vCttG5RATI47fZ1FYK6Wletrbl4khR+
 FBd4/Bzq3hdd3d3kvWF439im4V6Ee8INpp5A2p/f/Yis/Bd2zXwlQTTUKN9NgnK6NEqHMUZWMKe
 e5+mElGz9IcA4gRx94u9iK8RoyNbVVf6N6CjTpoCDO45+xRaDj26e
X-Received: by 2002:a05:620a:1187:b0:787:24a7:78ff with SMTP id
 b7-20020a05620a118700b0078724a778ffmr5030563qkk.11.1709121984066; 
 Wed, 28 Feb 2024 04:06:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF7bnOdQcduImmYm/ENn04XHMEypibigHQxOnTliB21hwG3sOF6DHAoiTBMm81J/nVxPUUGAQ==
X-Received: by 2002:a05:620a:1187:b0:787:24a7:78ff with SMTP id
 b7-20020a05620a118700b0078724a778ffmr5030545qkk.11.1709121983759; 
 Wed, 28 Feb 2024 04:06:23 -0800 (PST)
Received: from [10.33.192.181] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a05620a034a00b00787e11574c5sm1803384qkm.125.2024.02.28.04.06.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Feb 2024 04:06:23 -0800 (PST)
Message-ID: <54fe3a53-5bb8-4907-94ca-817c3000048d@redhat.com>
Date: Wed, 28 Feb 2024 13:06:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] Add device DM163 (led driver, matrix colors shield
 & display)
Content-Language: en-US
To: =?UTF-8?Q?In=C3=A8s_Varhol?= <ines.varhol@telecom-paris.fr>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-arm@nongnu.org, Arnaud Minier <arnaud.minier@telecom-paris.fr>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>, Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20240228114555.192175-1-ines.varhol@telecom-paris.fr>
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240228114555.192175-1-ines.varhol@telecom-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 28/02/2024 12.31, Inès Varhol wrote:
> This device implements the IM120417002 colors shield v1.1 for Arduino
> (which relies on the DM163 8x3-channel led driving logic) and features
> a simple display of an 8x8 RGB matrix. This color shield can be plugged
> on the Arduino board (or the B-L475E-IOT01A board) to drive an 8x8
> RGB led matrix. This RGB led matrix takes advantage of retinal persistance
> to seemingly display different colors in each row.
> 
> 
> 
> I'm stuck on some issues with this implementation :
> 
> 1. Tests
> 
> TLDR: how can I provide a test or an example?
> 
> I've tested the display by running custom executables and
> comparing to the result on the real board, but I don't
> know how to test it using a QTest.
> 
> `qtest_init_internal` sets `-display none`
> so there's no way to test the display visually.
> 
> There's no `visit_type_*` for arrays so accessing the DM163
> buffer to check its content is complicated. I could technically
> access all the elements in the array (returning a different element
> each time in the getter for example), but that seems sketchy.

I'd suggest to try to take a screenshot via QMP or HMP. If you need a third 
party binary to get something on the screen, it's maybe best to write an 
avocado test instead of a qtest. See for example 
tests/avocado/machine_m68k_nextcube.py - it takes a screenshot and then 
converts the console messages from it via Tessaract to text and looks for 
the expected strings there. Alternatively, have a look at 
tests/avocado/machine_s390_ccw_virtio.py - it boots a Linux in the guest 
that writes a string into the /dev/fb0 framebuffer, then takes a screendump 
and then tries to find the string in the file. The latter could maybe also 
be done via a qtest if you know how to set up the framebuffer without a 
guest kernel.

  HTH,
   Thomas


