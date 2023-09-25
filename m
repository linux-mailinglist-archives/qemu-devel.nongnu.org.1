Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8927AD518
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 11:57:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkiJs-0006I5-D9; Mon, 25 Sep 2023 05:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkiJq-0006HM-BR
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkiJo-0004Kq-Lc
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 05:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695635753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=AEnNfmCfJCGnvlwfyZIoRzWyoTtyiyv7zDWN++5oOwsF3mPp8RT5CCc7qe5cz2fhfQdB9V
 Wp9elMRMmrow44es31kLwFaysz3EdhX7hiS99e/p4TM/OrzKGWNJ8+dRiOgs9mFrus9Zbd
 LPpnMvRB03aPYr+zDT5o/fS1sgDizGc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-JzRWF536Og6DN4YVuoUNyg-1; Mon, 25 Sep 2023 05:55:51 -0400
X-MC-Unique: JzRWF536Og6DN4YVuoUNyg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-313c930ee0eso4411300f8f.0
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 02:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695635750; x=1696240550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=DY7PEzXY4pMYs0trDBf/ciBvUCM9cE68ymrQCm18ENkr4Jt3QthsfrJKbNNc7laIhB
 arsrTOb74cE2QHWM4jGNJO3jHxD7umc2HAByeemvN+s0M2cJ7fAD/5kdWxXGB1Ixu+IA
 pe9/HKuSehMt2RuDFAM21wz2TA9DTcTVgh+5KBCTjdy3msRK6jCx+VOp4EOm8TJ0qKe5
 zDXlNXSpcDcen2UaWqwa8vg2G7ZmW6bEJ3kFWDcFSCUEtUIMVNNl0rSD93w2fD4aRkwQ
 rHul7OJL1lPDOGScLhgY3n4pL2akB2dGbs6CAtvtlD0ef0Op92n44kF+kicte4wsRst3
 xhLw==
X-Gm-Message-State: AOJu0Yyu7Q6FXf9GPeZLaJK1MLvcNqjhNSZEkC56d29ywuHbqJftWjYN
 TsnSeY3Hh3Xf569BuxRA7iL4lk2INXSZhRbO+7lFCWLIVc1+BmNbPudsUvbUJYcOwXGQe/rVSFD
 CdlaRPVS7ApQAOBs=
X-Received: by 2002:a5d:6a46:0:b0:31f:edb6:3ad4 with SMTP id
 t6-20020a5d6a46000000b0031fedb63ad4mr5416238wrw.16.1695635750521; 
 Mon, 25 Sep 2023 02:55:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE80kI7XjqCVWTp1jcBIiaXIAsqD6oL86Map4mCy+uktBbA6wGmjBktHlZryybTayoYcUXbTA==
X-Received: by 2002:a5d:6a46:0:b0:31f:edb6:3ad4 with SMTP id
 t6-20020a5d6a46000000b0031fedb63ad4mr5416220wrw.16.1695635750155; 
 Mon, 25 Sep 2023 02:55:50 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 b1-20020a5d4d81000000b003215c6e30cbsm11271807wru.104.2023.09.25.02.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 02:55:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, qemu-stable@nongnu.org
Subject: Re: [PATCH] hw/scsi/scsi-disk: Disallow block sizes smaller than 512
 [CVE-2023-42467]
Date: Mon, 25 Sep 2023 11:55:48 +0200
Message-ID: <20230925095548.461345-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230925091854.49198-1-thuth@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


