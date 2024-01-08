Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB2D082766C
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 18:39:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMtZc-0005nU-DG; Mon, 08 Jan 2024 12:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rMtZZ-0005mU-9X
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 12:38:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rMtZU-0002xs-8J
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 12:37:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704735475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=Iz7hT0tGkKJFFah13yZgYkbS6QP44wNDqlGJBst2drHPNsW3x5lKipPllNR/muosSNhgEo
 4IMgbdG61DxwBxf4tGxNEpJ37ObCg/TrOhEMTzvAMeNoCxxHqtRWG4OI7keCegkljV28Rr
 Ba7UxVUXUicdBxUE9rrsOWk8hl7UM8o=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-KYJlbrfzPUqVuq5qA3IdbQ-1; Mon, 08 Jan 2024 12:37:52 -0500
X-MC-Unique: KYJlbrfzPUqVuq5qA3IdbQ-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33768a5aea7so896004f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 09:37:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704735471; x=1705340271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=mltwlcQCrBXAH4apl9QksEH4HxSuyqfXcdPsHoltOSHxvvUv+hM6RaEd7AHbG1FuFK
 /gD1ywU7zy4IzmjwN1AZpNAZvBBQY1l8Dx4+38aiVFzYaNiR87bmaw8FYX4D/OiunDMh
 6UHyFwhoqAs87PEMlmpdIO57ics5VHPBazx31N0PkKChfazkOmotKbpL+9+EcNKDZH89
 o9Z4jg+mX45x3IPY0bGJi7uE7ApqKX6jHsW5KgnwIrmXufVvV8qxdETTTjQNRX3iM06Y
 pUrR1PMkFezaakOPrN8ZlQkzxfHvks5w87Efhd9cSTdsi+uv5pAX6x5MsJ7crHKnzwTx
 ykLw==
X-Gm-Message-State: AOJu0YzAAXV8A4Ti6h62NiEkuzi3y1zUjnRHCbMQXjlJw8Z2A6D1NkuU
 fe9y2ECIcb3bEZp8RrZSGNds2qTVPqDFQEXriYrmsIhIiwqpt/dvS0pukIfN4JwTWqUbLst5MA1
 tCurrsH8QK5hMSm8HPdsqNAU=
X-Received: by 2002:adf:cb92:0:b0:336:8143:9365 with SMTP id
 q18-20020adfcb92000000b0033681439365mr1483265wrh.130.1704735471231; 
 Mon, 08 Jan 2024 09:37:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHLnn8ffEMEwbn80BUB1pinfkasHXLT/Gducv2rZ+jKsG7uR5dmznZ9BjIV0eSEcNRliGd2Rw==
X-Received: by 2002:adf:cb92:0:b0:336:8143:9365 with SMTP id
 q18-20020adfcb92000000b0033681439365mr1483258wrh.130.1704735470872; 
 Mon, 08 Jan 2024 09:37:50 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a5d6384000000b0033760ad2eabsm188054wru.69.2024.01.08.09.37.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jan 2024 09:37:50 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] tests/tcg: Don't #include <inttypes.h> in
 aarch64/system/vtimer.c
Date: Mon,  8 Jan 2024 18:37:48 +0100
Message-ID: <20240108173748.162393-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240108125030.58569-1-iii@linux.ibm.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.243,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, TVD_SPACE_RATIO=0.001,
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


