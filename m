Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1AF94159F
	for <lists+qemu-devel@lfdr.de>; Tue, 30 Jul 2024 17:46:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYp1t-00071m-0u; Tue, 30 Jul 2024 11:44:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYp1p-000717-Gw
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1sYp1h-0003AE-T9
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 11:44:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722354276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=BQo4XMWga1mlhWKeTBkwhrtBcojk8/OGr4GngXi1Fo0RXhvo3v/+6D6Av81aqMOACWVGja
 +z8zsgGfeidSlGbD225Exb2UyN5bExPrZlJ3PivTyxHwkwBtRBd84j+zJLX4WLUhSQRwa0
 4B10W+0+/wtlTW+HDkfNKWJYRBYbMPE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-OBORHj4nPFSHO0DQ2JX8Gw-1; Tue, 30 Jul 2024 11:44:34 -0400
X-MC-Unique: OBORHj4nPFSHO0DQ2JX8Gw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-368442fef36so2822742f8f.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 08:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722354273; x=1722959073;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=MYtlS0fAgz8zraOHEknMLwcy7kJ/NPlsxWdqLxBdMOtP4NhY7i/aWyR0oxVoIAaeVV
 DlU0vim3VQ3P/ft0K1hmQCZdwYWhtkWqSx0zjSQxpxOSKCgr2Zu4GW8fO85DU4f1K9na
 0i17GLe7EVSlQCA4ZJnFO/WaafNDckjRlB2ZNBWFJUZCSRgiZoT9EMRAf6iVgLT6YJVq
 vMIMyhfay6IwYBpIoH/NqbZJAORzTp0YGQnI63K3xPyBHHH4qo/NUDPqRY9G7SbdqcbZ
 ipCrR08/3Ia8NCmZJ+Ee2QVS1pbVOBhvcD5n5a3m4Nbvop5V+C5lHVQMPKeMaAkTHBpf
 OOVQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjgHCTSeR7/LwgZV3CzMQd0Om7O6Ox1KW5L+X7L4/3LEISnS7zpEb+p0obN/eTizG1Y/ymfEpuov3EPx5flrC6OpsIBak=
X-Gm-Message-State: AOJu0YwyGz7sDoGh//rBYUqIN+Uth+eRXof0QtyifUeSEqq/yNqnSb3q
 Y+g6b5E9Fr17fsD7v7iHASti3hbLLpLswFTmy1r1kSBAsHri6h8EIdMqalFO794H/SNTCg0YO+e
 q1GYz8UasaHsz1J/i9KAwwyfNaNMJobOk+ec/WIg00JodNlWLvDds
X-Received: by 2002:adf:f00c:0:b0:368:7943:8b1f with SMTP id
 ffacd0b85a97d-36b5d0d0f9dmr9942890f8f.43.1722354273581; 
 Tue, 30 Jul 2024 08:44:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIOOp2uQ8K/GTmT9W6RtebAtf6YHFGkGdblB427jtNYszNQ/lJg+4z2I9hCA/FPAJK2Mfgew==
X-Received: by 2002:adf:f00c:0:b0:368:7943:8b1f with SMTP id
 ffacd0b85a97d-36b5d0d0f9dmr9942864f8f.43.1722354273246; 
 Tue, 30 Jul 2024 08:44:33 -0700 (PDT)
Received: from avogadro.local ([151.95.101.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab23f21sm658705966b.37.2024.07.30.08.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 08:44:32 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Subject: Re: [PATCH 0/4] i386: Clean up SGX for microvm, completely
Date: Tue, 30 Jul 2024 17:44:30 +0200
Message-ID: <20240730154430.69879-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730045544.2516284-1-zhao1.liu@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


