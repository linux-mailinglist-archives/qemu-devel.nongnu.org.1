Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8D47F31F5
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:08:20 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5SLt-0004fm-Ax; Tue, 21 Nov 2023 10:07:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5SLq-0004dG-TD
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:07:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1r5SLm-0006WB-Sb
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:07:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700579262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1GSjdejaIkSnIT4cCLg/NjGrQGmQeD/4fkrAtjM02OY=;
 b=T/8Q8qa6uOs1GevNpB/WZ5u+gzHJPUjUws6Cw7AIcERcdPAVn+jaJc0a+SQVoXqopxYZsJ
 LXUynvbMAEIT1SimZN1/Y9zLWmLhCYkmZZxFhOVHAYYl8FbnWSpGqAbtT7CpkVeGnoZ8df
 Iu1gmaiT7n4vCWiJX+YLTWj2yZDfvYA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-32-KAkc3kYyO2GwArZKwdf1Gg-1; Tue, 21 Nov 2023 10:07:41 -0500
X-MC-Unique: KAkc3kYyO2GwArZKwdf1Gg-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-77a02ceef95so107919685a.0
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 07:07:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700579260; x=1701184060;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1GSjdejaIkSnIT4cCLg/NjGrQGmQeD/4fkrAtjM02OY=;
 b=hyjZ7iafQdhEUqAnOspuJ6FTqobaGCt94G/RA8aW2yrdDuj8e5rOXYkNy79E8wqTfI
 GyKnbPTqjZDkvtdzsgnHtHmK2MS5Xp5aOm82IobY/W7AxpFLn9pJ2a/oxr/hhsf402k/
 lnJnYyl3I0CnsgiZo4KoJNeHG+1uWQlPrHF/FWsMYrAh/wNdFwXDqgGNtrDgVUqSLeJ/
 QCNnD8XuFzdQS1mH1PTymTG/UPdH2ERA2tNFxmf2hN0y++HzSlYmPyB45z0y6qcsr+nQ
 kqg8BYYSnGbw0x26i+Om3mb76POYvqqgfDBUlKI3vj/QIP0IJTBOOOXHOZPY8L3YpOKB
 XE5w==
X-Gm-Message-State: AOJu0YzflmuaKZAjtTSQ/Ds53SPnYbx8hvcKCqEKc3TLq/+g29aYx7SW
 DXFOrimXrYc5Oj2eo7mKiaz/cS2UwpaKXEqNVCVm1ITqI8MhwaZ4ydMxm9ItNxhFheZAwtGnbh7
 AO8D4IRf1pLPnT7U=
X-Received: by 2002:a05:620a:4542:b0:76f:167a:cc4d with SMTP id
 u2-20020a05620a454200b0076f167acc4dmr12735165qkp.2.1700579260575; 
 Tue, 21 Nov 2023 07:07:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFjweFjjeQ8ovbGJ4dvLGwAqwkyN5Ew7Psv6hQhHeSlFa6QzyzS+CAG2RHDmXQX/OMjMkyuXA==
X-Received: by 2002:a05:620a:4542:b0:76f:167a:cc4d with SMTP id
 u2-20020a05620a454200b0076f167acc4dmr12735141qkp.2.1700579260250; 
 Tue, 21 Nov 2023 07:07:40 -0800 (PST)
Received: from x1n (cpe688f2e2cb7c3-cm688f2e2cb7c0.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 qf9-20020a05620a660900b007676f3859fasm3696730qkn.30.2023.11.21.07.07.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 07:07:32 -0800 (PST)
Date: Tue, 21 Nov 2023 10:07:28 -0500
From: Peter Xu <peterx@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Stefan Weil <sw@weilnetz.de>
Subject: Re: [PATCH-for-9.0 18/25] util/oslib: Have qemu_prealloc_mem()
 handler return a boolean
Message-ID: <ZVzHsJFXaolo5_b0@x1n>
References: <20231120213301.24349-1-philmd@linaro.org>
 <20231120213301.24349-19-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231120213301.24349-19-philmd@linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Nov 20, 2023 at 10:32:52PM +0100, Philippe Mathieu-Daudé wrote:
> Following the example documented since commit e3fe3988d7 ("error:
> Document Error API usage rules"), have cpu_exec_realizefn()
> return a boolean indicating whether an error is set or not.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


