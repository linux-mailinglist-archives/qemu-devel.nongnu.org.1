Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDE27F31BC
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 15:57:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5SBL-0002VX-HY; Tue, 21 Nov 2023 09:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5SBJ-0002Qv-Ot
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 09:56:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5SB4-0003NQ-GO
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 09:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700578597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q1tol34Cz9PAtyxmhj5j92MDJbcFqe96Y+qbUd3Cbrc=;
 b=GAGkxwDrMkb/Y85acNCvyspYEdisZXyqxgMUyS86phXp9YbbHDBwnXmgjQP8t7F5sTv5JA
 TKBI450Uv4vEy8kRwKYoqtIZvnPxFVgUYsZSjYMo2hzvqNmGK9yHJlsSfFho2BmJChxjS7
 xb9S38tchjyiumg7gwMeV4JcnUTkGQw=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-zwJ2pumVN-ioMVVWfqEmqg-1; Tue, 21 Nov 2023 09:56:35 -0500
X-MC-Unique: zwJ2pumVN-ioMVVWfqEmqg-1
Received: by mail-ua1-f72.google.com with SMTP id
 a1e0cc1a2514c-7bdcb82e66bso507610241.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 06:56:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700578595; x=1701183395;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q1tol34Cz9PAtyxmhj5j92MDJbcFqe96Y+qbUd3Cbrc=;
 b=Gv0M7Kw2sLuB3nS9TKvvyOpJgW1h5NMg1OmVRfE0oMSZ8U3PKmLeeSNO2Y4/gz+uOe
 wVZUlxDWfkT7V8sPUPLJxeR1CnDzAbyI+DryMiCn7X6qEvFR8BObvmknvxzHc5JMM/1H
 ppIaTlIb5UfLhEvCfrk70qHJ2U9ZHIkUU3P+fuNMdC/xDT1dbO69qusqnqvBUEoh6xl8
 LReGqrIQSBS1SAU5Liy4zUOBZoVmwDiepewOCwBLWSyhm7kmDVs5c5ptWG0R4GDEi8VU
 S+lMuxV2H8Nu563BP066evTbItoU5dxSWoHrNIKGzNK1gfoVfNsxlJ0PywLVbiNx2ysW
 fyfQ==
X-Gm-Message-State: AOJu0Yyaan/5M3FkqbPYIQAZvwBwGL2oV1SvQJmE5X5SAhplvuINGlKN
 EPxiBv6mFJksEdlWQ41yLQWs0UjEIuOvxqrJ1/xsXisaZjUpyVmcciwRKm1ukyFRXJsLhpEvMz2
 JA2rxiUca8fDLSBg=
X-Received: by 2002:a05:6102:2c4:b0:462:ba47:96ba with SMTP id
 h4-20020a05610202c400b00462ba4796bamr729216vsh.0.1700578594823; 
 Tue, 21 Nov 2023 06:56:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH459MvquDx1Fwa50BVQ3S7sjWAzF6AumJueMxbfnMlAxZK1OFEuc+R5VxumH/tUvWCUqJ32g==
X-Received: by 2002:a05:6102:2c4:b0:462:ba47:96ba with SMTP id
 h4-20020a05610202c400b00462ba4796bamr729173vsh.0.1700578594241; 
 Tue, 21 Nov 2023 06:56:34 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 bn44-20020a05620a2aec00b007758b25ac3bsm3673657qkb.82.2023.11.21.06.56.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 06:56:33 -0800 (PST)
Date: Tue, 21 Nov 2023 09:56:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH-for-9.0 01/25] memory: Have
 memory_region_init_ram_flags_nomigrate() return a boolean
Message-ID: <ZVzFH6R34kXn7-OF@x1n>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-2-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120213301.24349-2-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Nov 20, 2023 at 10:32:35PM +0100, Philippe Mathieu-Daudé wrote:
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have cpu_exec_realizefn()

s/cpu_exec_realizefn/memory_region_init_ram_nomigrate/

Similar issue for initial 3 patches (or just not call out the function
name).

> return a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Other than that:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


