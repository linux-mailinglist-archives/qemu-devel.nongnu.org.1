Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACA97F71D4
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 11:42:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6Tdh-0001Mr-TO; Fri, 24 Nov 2023 05:42:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6Tdf-0001Mi-Kb
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:42:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1r6Tde-0004nr-7M
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 05:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700822541;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PNpGpdY9x6odTkiNK8w29zuaxM84dgm29zEilCtWVj4=;
 b=W4foF6168nnog0XlFfHQusIWcwCyc7rygbIwDYoupQkKvSux+M9nhv5FpO70W2HLW4r+GB
 wFy3DszkxXGpdMihWJEAdiQiFuWIhIFp1VCWAaZ/7OYzjOY4jGCcPpVGMtnfjXAd32IDhD
 ZfHW6QNn5sOEcB/elONqqo+Ky+kpDaU=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-270-WYtmevIaOyq1EIx2lS1uEw-1; Fri, 24 Nov 2023 05:42:19 -0500
X-MC-Unique: WYtmevIaOyq1EIx2lS1uEw-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-543f45ab457so1073331a12.1
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 02:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700822538; x=1701427338;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PNpGpdY9x6odTkiNK8w29zuaxM84dgm29zEilCtWVj4=;
 b=ltcdaw4/yzhrMb3ryIXVzwxiNtPTHgcnw6SBqdmnqVf3Mbf1pG2nCV5crq4CHpzA9P
 9CWxSSv3tz8MNC3Eac13bv4xDSp+QKxKU706yzkJJwlvjErDm0Dlx28WECOxxMdEhQHK
 FbAvovj6M/EuC9rq+7yeBAZ7I90y3wU+UumIKtSW5Xrb1ECoeTzc/xeojSBEgZTASWWS
 LSEYZRePI0P9qDSPn6TCx93WsLl3LOXYTDJCKHylPzvqbKkX+hqOJ8rvsVbso3Oua/Gh
 xlv1E+Iwslh3NuWMizR52x1r69gJcdsJVd5W6KZpFh0aMZWKYhGYKsyjxsduJkXB36Qf
 pUaA==
X-Gm-Message-State: AOJu0Yyz1GHWurreM2U0QItHQ/Z2ZYpjNEprs05v5auWeu5GXgwPjDvJ
 KIlMLUhIItUCLhCa8qpM1LHZl9zziManhmai2N517pQkEfd46dhuUW/Qk3TOeZDemcLq5Lkusb8
 DPRKSYjWWjdiqfkEVs7d9La8=
X-Received: by 2002:a05:6402:285:b0:54b:5a6:d078 with SMTP id
 l5-20020a056402028500b0054b05a6d078mr468202edv.4.1700822538150; 
 Fri, 24 Nov 2023 02:42:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH77WWgO6E3U1Sc5nsO+fB1XuxQw4uh37o0Zifu//oSo3jY0tpwLHZG4jXFhjGGhNSQuYPHlA==
X-Received: by 2002:a05:6402:285:b0:54b:5a6:d078 with SMTP id
 l5-20020a056402028500b0054b05a6d078mr468188edv.4.1700822537853; 
 Fri, 24 Nov 2023 02:42:17 -0800 (PST)
Received: from redhat.com ([2.55.56.198]) by smtp.gmail.com with ESMTPSA id
 z15-20020aa7d40f000000b005488bf98309sm1654771edq.56.2023.11.24.02.42.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Nov 2023 02:42:17 -0800 (PST)
Date: Fri, 24 Nov 2023 05:42:12 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Phil =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 2/2] docs: define policy forbidding use of "AI" / LLM
 code generators
Message-ID: <20231124053749-mutt-send-email-mst@kernel.org>
References: <20231123114026.3589272-1-berrange@redhat.com>
 <20231123114026.3589272-3-berrange@redhat.com>
 <87r0kgeiex.fsf@draig.linaro.org> <ZV-P6M8seKmMKGCB@redhat.com>
 <20231123183245-mutt-send-email-mst@kernel.org>
 <ZWB4MMrW1JttcxqI@redhat.com> <87edgfcueq.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87edgfcueq.fsf@draig.linaro.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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

On Fri, Nov 24, 2023 at 10:33:49AM +0000, Alex Bennée wrote:
> That probably means we can never use even open source LLMs to generate
> code for QEMU because while the source data is all open source it won't
> necessarily be GPL compatible.

I would probably wait until the dust settles before we start accepting
LLM generated code. If nothing else, generated code quality
in our niche area is at this point still nowhere near being useful.

-- 
MST


