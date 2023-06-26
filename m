Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E84C573DCF3
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:10:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDk5b-00088P-Ac; Mon, 26 Jun 2023 07:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDk5Z-00088A-94
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:08:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDk5X-0007mW-Pb
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:08:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687777734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=WG9+BBE8CXVoyKDKk+FBT7RW+HntthsngNBEcCVWSB1kHDoaD+rDl3d6w4HKYcQik27lj5
 /90tQ7MC3IPrP6UPBpPdu/oXx2Pyg3jKa5Fhbd5K77sKzWC5hYBu+bLPFL6VxUHUY5Itn/
 SjV+XGqbhUHUM5pudXJSzUoIc1DAvDY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-sICPFWzCOPu9XkmvTHcVmw-1; Mon, 26 Jun 2023 07:08:52 -0400
X-MC-Unique: sICPFWzCOPu9XkmvTHcVmw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fa88a6a185so9803935e9.0
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:08:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687777730; x=1690369730;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=f5x+J45jHxtg0VjB+FDkK3qNTICOhSYun9JGedeb6Q1gS+7n/C+ZzXPjp4wzmMaZNR
 aQMEMWLod11Mm3oRiVYM1BPcdnjFGdZf4qYS9BW44/cFgAM/icrk2dEHOJrq6nrIyRMk
 DJsOyvARZaVzM04cLL0U+vJYvF+xv8gOVcHQJLm3vxgRSsBGSL85TxJlG3zlKcdRZ6mS
 KOY/pyo0o7rur4jmkP6GTyOdOW5Bh62c9Ue4hS4XvG8IUAD3j+r93H4qCWIAjVGykSDM
 6Kjsb5jTXIquBphfZONbrs6bhO6UjeRZzj47QjEJyw4JEedF41n1/IgJ97hDyaakX/3V
 NjdQ==
X-Gm-Message-State: AC+VfDz1eyOQats4Fqnr7oJKV9MlBp+ao63ODhlG+tsorlzQmIhQaDfe
 fUybpCir9Kq+Rcf2QD5QVOndb/YRaMI6oKyCRqOZlERbQ1RCZMKtwr949NedZHfEsd2nA6I9b/H
 MtFYNEwhegmhnU3XqOqguDeg=
X-Received: by 2002:a1c:f70d:0:b0:3f7:3685:1e10 with SMTP id
 v13-20020a1cf70d000000b003f736851e10mr22240208wmh.40.1687777730236; 
 Mon, 26 Jun 2023 04:08:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4L7gXjwNP3JXt/0pBfGSmlEZeXCePa3tNm79WC9E44Pgkcm4ZSaQwhG0G/wDQNKmXxw3jkfA==
X-Received: by 2002:a1c:f70d:0:b0:3f7:3685:1e10 with SMTP id
 v13-20020a1cf70d000000b003f736851e10mr22240198wmh.40.1687777729920; 
 Mon, 26 Jun 2023 04:08:49 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 h2-20020a1ccc02000000b003fa74bff02asm7318317wmb.26.2023.06.26.04.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:08:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH RFC] icount: don't adjust virtual time backwards after warp
Date: Mon, 26 Jun 2023 13:08:47 +0200
Message-ID: <20230626110847.162190-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230625083731.3108-1-npiggin@gmail.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Queued, thanks.

Paolo


