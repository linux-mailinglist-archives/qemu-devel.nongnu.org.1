Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AAB7C8390
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 12:46:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFfm-0002A7-9J; Fri, 13 Oct 2023 06:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrFff-00026f-Pr
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrFfe-0006ar-8l
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:45:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697193927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Rzt+Mc53XyCw9d4RXak4DvQEnH4E+i9H4rWe0yfTDX8zTYkE+rzUsb61qVfNWlftQFCAzo
 FDdo1eZdZJ4r84VEBZviR1dHhO+RUSQ7iX8swQqri2/Yyf/+VV4QXBqNKFX5l/VaN61Qua
 U1UrYsgsldqdYdCJtIXRFxwMdhkhw3A=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-BKaCuXHLMTiooXQ9BoSokQ-1; Fri, 13 Oct 2023 06:45:11 -0400
X-MC-Unique: BKaCuXHLMTiooXQ9BoSokQ-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-9a62adedadbso145609766b.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 03:45:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697193910; x=1697798710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=dd2YWcZyFPDGUfkKcjuPKMK/cg7IEIlTPUzXDtLyPsgr9/MFRmETAoFUJ12y56AC6e
 9uibp+QlDY2+vcQLY/3diL2IbK1XtAyj3Tjq1DZkLajoTbKEdwS+/6N5ruQNvK3N6Nfi
 1PSw1azSf+2vyTP6GiZrA5AZ6Q6sSjp62Tmc8AXt9NjWakuDjkUOq/Z/DLC1WJNbI2Qf
 +DSQzEwus2mv3J2bk5nMmMOVtqelztEsz/hdKKiigyieiv7CVhDa0L+/l8W0B4Dh2Hv7
 Qr91EtNjQo48DDpv+lc/D1UYlBr5JNi8UKWhhGLm3jMZLsVnqqXnpPMolhp/NQpm19Ac
 VIHg==
X-Gm-Message-State: AOJu0YxJY4jyuRsqaRpsGKKF7wgaRLKv/Wh9VyLxY1WM9Htm6JOkgOZA
 jz7gcPwsVboHpzya/HEwcZlfNJzfRGUETrs8xx+IG9SCf7uWB0sH1+DkWWotDKbvldoPNnseseW
 ccoxVVqZnViDTQB8=
X-Received: by 2002:a17:907:7850:b0:9ae:75dc:4589 with SMTP id
 lb16-20020a170907785000b009ae75dc4589mr25815739ejc.64.1697193910320; 
 Fri, 13 Oct 2023 03:45:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE93RXM8higyjyP+neEPOzxO3qqeRAghg0HcqrYqh1CxIvuyY7kxQYdGKZZn8QoBZSXs0pj1Q==
X-Received: by 2002:a17:907:7850:b0:9ae:75dc:4589 with SMTP id
 lb16-20020a170907785000b009ae75dc4589mr25815731ejc.64.1697193909968; 
 Fri, 13 Oct 2023 03:45:09 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 br13-20020a170906d14d00b0099cb349d570sm12239107ejb.185.2023.10.13.03.45.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 03:45:09 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] scripts/get_maintainer.pl: don't print parentheses
Date: Fri, 13 Oct 2023 12:45:08 +0200
Message-ID: <20231013104508.548446-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231013091628.669415-1-manos.pitsidianakis@linaro.org>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SPACE_RATIO=0.001 autolearn=ham autolearn_force=no
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

Queued, thanks.

Paolo


