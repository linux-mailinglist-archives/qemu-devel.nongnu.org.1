Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB6A83123E
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Jan 2024 05:58:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQKSn-0006Dk-L8; Wed, 17 Jan 2024 23:57:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQKSl-0006Db-Es
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 23:57:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rQKSk-0002No-27
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 23:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705553829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yHM45heQvvrXuElPkC5VxLz0v4NfQiClg1sVzV3llWA=;
 b=Es1Oe0CUD9nL8ppMfNh8Eo7gklW+D7Um20q3QGzy2lLaFOPSShf4Bz87Axk0zw79Td/7Wr
 OdiyIkDZj5UiANhT+EkdIFiZvMbBif/1uQAB+RO29YbYuRW+PxgR5dJIkGxR38AGrHnNed
 HtDzIf7WwKqBnMviuXrTPw9ji5Dyb/0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-uUOHVCHeOiGa40QDHlnWIQ-1; Wed, 17 Jan 2024 23:57:02 -0500
X-MC-Unique: uUOHVCHeOiGa40QDHlnWIQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d99cdbeb9dso2876572b3a.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 20:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705553821; x=1706158621;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yHM45heQvvrXuElPkC5VxLz0v4NfQiClg1sVzV3llWA=;
 b=xF4pb6XJSQ4rWnT87RdbujwgvAo2tjduZ5seUvtCQUcnkh/ldNiBkTQFOnR3Xj3oZv
 5jUfSAUgfFC+2cezoi+C7mfgwPC4SGi//JxnawjkbrUo9PVXqGsjZ5D7Jg6gD2+06/Ju
 C+lnpweebwALSZQsRIr2QJJvHSKa0logNzC0wE1WFAna4jEvpWh59eXdAdeIse+P4kg2
 Kkl3XF68C9HOL8PDTSoUNeByRvV4BgjHtnoilrCI3fTaGgtYM718OK0c07uwtJ+uV6yS
 4i5kFK/80Xm+cmNI0uUeHgAqnTWula/nA1s5RgPHp2wFIw/3N5TLscDex2FpfsdUQhXy
 9PCQ==
X-Gm-Message-State: AOJu0Yzmq0sBbDbUN2dwBAvQTw3/Q3x5xJKpeUNJ0jROYMD9VaGO5+vM
 548O9Xr5RUIlxyKyYRqvgKjJjB6zaMUPmQZ4Fv9a1T7t6k4YZjv4+nqlQ62L+boaKamZGJYyiPK
 Lq9H9Oi6hHyrqfNI2n5jlTUIcCvnqtO9faW17Bslgh2SWTsC459ew
X-Received: by 2002:a05:6a20:2d2c:b0:19a:e0cc:dd46 with SMTP id
 g44-20020a056a202d2c00b0019ae0ccdd46mr576267pzl.4.1705553821177; 
 Wed, 17 Jan 2024 20:57:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGUf6hmoG9RPgRDW+kz5GRrsApBX2KSD2wYKngA2DdN8dW9Oz2wsowC1hyNaJ8pF8CW8h9uIQ==
X-Received: by 2002:a05:6a20:2d2c:b0:19a:e0cc:dd46 with SMTP id
 g44-20020a056a202d2c00b0019ae0ccdd46mr576259pzl.4.1705553820809; 
 Wed, 17 Jan 2024 20:57:00 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 i9-20020a17090332c900b001d5ee6cb899sm467306plr.201.2024.01.17.20.56.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jan 2024 20:57:00 -0800 (PST)
Date: Thu, 18 Jan 2024 12:56:58 +0800
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] userfaultfd: use 1ULL to build ioctl masks
Message-ID: <Zaivmghj_1kB0Arb@x1n>
References: <20240117160313.175609-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117160313.175609-1-pbonzini@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

On Wed, Jan 17, 2024 at 05:03:13PM +0100, Paolo Bonzini wrote:
> There is no need to use the Linux-internal __u64 type, 1ULL is
> guaranteed to be wide enough.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

queued in staging, thanks.

-- 
Peter Xu


