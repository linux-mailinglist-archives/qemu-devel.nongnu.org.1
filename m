Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D7678D527
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 12:42:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbIdV-0004HT-Kq; Wed, 30 Aug 2023 06:41:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qbIdT-00049G-R0
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qbIdR-00057h-SC
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 06:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693392076;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=N1jDTleD/yarZ7A1iW/OkSo9+rDoSPI9sDlKSUnoWHJxWTW724OY2ckJtOoROUKzkmxgkF
 7W1OXV4GwmVvV+TGOmOHoqWRwRHawUxxIeLFWf6oGpAoZEdUTjEm5cbgwlrr/Yk6CFEcHn
 LQbOBz/hJBG3hlkFruLbA+aszJwwtvE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-R9JiDYD1PxikcklkpYu3Mw-1; Wed, 30 Aug 2023 06:41:15 -0400
X-MC-Unique: R9JiDYD1PxikcklkpYu3Mw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9d0b3a572so67118091fa.1
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 03:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693392073; x=1693996873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=CAYQYI6uG+mIkOjvF0TkEcJn8mAqubc/KW5fpeBRF5lNuFWbihKE0Sh8tpO+DRt9Qo
 OhsL0NEYOj0QKME1nVbiuKAzp5QJtdwv9HKpwmz+2qsv/QaLNY44g6KLyB2ckjciA02N
 MCvW1vCTUK2aC1BnN+qCZswF11bxza+boAFoZZUuRkRVdiKOEM9toUvKQ8MRgfCVXdNf
 kIs0qJ/m7Lg2xNdYGf85m2O5VqIK8MqOAOWGDOgAyShyg2/XeaysOPRZwXAT2O/pI8Bt
 LhWxNsbRQI2PSrwSZcromRBGjDdBzerQf/ihcGuE3doriWPj617VEKHCb3caPhTC4J7z
 lKnQ==
X-Gm-Message-State: AOJu0YxwiG4jP0VNZ6mlApWQkPZzevwBLg8qU83E/9/k6fEWMi4Hh2Lf
 Tz+mYOT4Sqje5fuSc/JahUshYBYexWljDtPwZMwOZ1c9nsUt8H5oG7xR1Y3wAw2Xx/sqICYthkq
 saf0UotjBTzuAcBY=
X-Received: by 2002:a2e:9c50:0:b0:2bb:b626:5044 with SMTP id
 t16-20020a2e9c50000000b002bbb6265044mr1398032ljj.6.1693392073685; 
 Wed, 30 Aug 2023 03:41:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2n7ayCr1yJfn7DRaEN5cR4ENByNGy7oqnXMk6kAA4w93VhN/L5hxh5rjXRz0hYtJnMnEnrw==
X-Received: by 2002:a2e:9c50:0:b0:2bb:b626:5044 with SMTP id
 t16-20020a2e9c50000000b002bbb6265044mr1398017ljj.6.1693392073341; 
 Wed, 30 Aug 2023 03:41:13 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 17-20020a05600c029100b004013797efb6sm1878161wmk.9.2023.08.30.03.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 03:41:12 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Tao Su <tao1.su@linux.intel.com>
Cc: qemu-devel@nongnu.org,
	pbonzini@redhat.com,
	xiaoyao.li@intel.com
Subject: Re: [PATCH] target/i386: Add support for AMX-COMPLEX in CPUID
 enumeration
Date: Wed, 30 Aug 2023 12:41:11 +0200
Message-ID: <20230830104111.140711-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830074324.84059-1-tao1.su@linux.intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


