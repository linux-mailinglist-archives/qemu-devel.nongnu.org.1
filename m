Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 473197985E3
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 12:29:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeYjw-0007ZC-R9; Fri, 08 Sep 2023 06:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeYjp-0007YD-V4
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:29:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeYjn-0007D0-64
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 06:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694168958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=K8BSvQ2RYVNLa0WKnOaWhTP4pIzoP9DcFDAO9ChwiwT1BSy+XmTX45uZkzcKaAOcgXXHE2
 vsXB4uX8l9PvRsClK8VU1PcN6Oa/O5w8mw1YiFz0MquaPSxSBWO0Z/cttsHm1l2Ya1N8aB
 EcuToHS1e2/pOiZLxv/iwd997x5xdzw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-rxAaMqidMEeUBY2-Vahx2g-1; Fri, 08 Sep 2023 06:29:16 -0400
X-MC-Unique: rxAaMqidMEeUBY2-Vahx2g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-401db0c9d3eso14849815e9.3
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 03:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694168956; x=1694773756;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ABXg/AOurlP0hTTwq17F4ZZKRYgAwG6GShZGgcXs6ZDoYjrqnjmU1QfNgkD8wSJWRp
 8AViqNCKnNm994ptbIwpm/NCNmmzIa0LDAVJvouGhLk6UJtadLZFCQF+YBtMtvk/gug/
 yuBd6p0JjhQIep0Q3D0jtFwnUDGBL9V8Uwewo+AhdSLq3eE5HHs4Z9gpyJk/2kOwUs+U
 lfwNe1ocTHAY3ZAzuAi/iKn+5uPgb/MmUvK/40Vb685RcR774JGPJrfjdOcjrdhHDbcj
 TTGM0XblwRVcPeHOjHqVmum2+o6mBrcOUEom1Q1Kx57/SbLft5tHrM4cESfB6PCUWwco
 waxQ==
X-Gm-Message-State: AOJu0YzHvvua7ASKW4MdDLzY2BSiEMjwFMTMSfq/yyc/600WFX1lY5CI
 SUffpk+6j6isoKk6ChDHBbTktJFfdwumMccsAdaMfKJQ6RNaHGuvjcCXKlbdENrtSWpQvO3vw0y
 1URFmRaFb0SZFIsM=
X-Received: by 2002:adf:e60b:0:b0:317:5a3c:ed28 with SMTP id
 p11-20020adfe60b000000b003175a3ced28mr1747555wrm.6.1694168955906; 
 Fri, 08 Sep 2023 03:29:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxAcHV98ExI/jojVny+6juceRiMCUMTU67tWwhw0XWR4ZF9i8VKprwtFKOsAtw4rVKdNmSWw==
X-Received: by 2002:adf:e60b:0:b0:317:5a3c:ed28 with SMTP id
 p11-20020adfe60b000000b003175a3ced28mr1747543wrm.6.1694168955497; 
 Fri, 08 Sep 2023 03:29:15 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a5d4cc1000000b0031accc7228asm1726490wrt.34.2023.09.08.03.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Sep 2023 03:29:15 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 LIU Zhiwei <lzw194868@alibaba-inc.com>
Subject: Re: [RESEND] qemu/timer: Add host ticks function for RISC-V
Date: Fri,  8 Sep 2023 12:29:12 +0200
Message-ID: <20230908102912.535248-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230908033129.694-1-zhiwei._5Fliu@linux.alibaba.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


