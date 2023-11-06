Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDA47E28D8
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:37:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01do-0007M8-DU; Mon, 06 Nov 2023 10:35:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r01dV-00078I-KC
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:35:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r01dU-0004u1-1j
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:35:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699284931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=EbUg5E0MGmMQnfqOMLGavwQ3MABB56ByrWv8cwoN8Lzxnq5NLBMWlt1luSPWhztTmovuD0
 ca8Zea4XTRHLPYggZOy3Citz1wQ+M+pGu5mT5YihSPemhg38ZdmV0MlUf1F4+QDnCw3OSf
 mfjG0dKNJFaeBYv41LF3zabpmQUWcfQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-it7zwvLCN4mPn1nBZsoqiw-1; Mon, 06 Nov 2023 10:35:29 -0500
X-MC-Unique: it7zwvLCN4mPn1nBZsoqiw-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32f820c471fso2337165f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284928; x=1699889728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=dPKLbROgmBaWv4FczkuH6AL36OxPSU4kxJwRRmRXu9dzMus8nu+unlo9srANN593CY
 KfBeQ0ri/7n8OLV9H6hUagnAOw3UsUUwWIlFP3HU7M3+BH0Rjf8qBpWqur0yVlso1aDU
 vk8aZ4s6wvsxoP6tEkXAAi3yN/CU4SSC3SbHcUXRpu/zFH6TJnvSte27u4XdS52Tis5A
 kBHERvjrp33MuxfjDnA2fhi+iY8J7NcGZ6dT8uC2HWxnJoU9lRPdvojDn3HuCfbXFFRH
 /ygcJkrVvk7WrfqmV4+PwGXMpgUNkI+S7AvjvhcgORhwG6uLZ/YZ+frpb8MIUke61rc0
 q6bg==
X-Gm-Message-State: AOJu0Yyoam4yM7K/6Sc4lcAZ2T2OtjdCwdYn+Q9lCDyYqJ5CwysYiubQ
 sEhO9Ncd2HssTzaE6OGHNsGwmaW/vWozpQKmPsGPFc4H6NVha/WqJGCNO3kA3SUyQjUdJxZi0jO
 OTIqMoYEB8dKnl5dGLnDbBBo=
X-Received: by 2002:adf:e544:0:b0:32d:82b4:1957 with SMTP id
 z4-20020adfe544000000b0032d82b41957mr22964692wrm.40.1699284928152; 
 Mon, 06 Nov 2023 07:35:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGB+hvEtcEYbw7nHXb6mTXOGKcehrK2MMN0/X/aJawX2ZrpkQHnPCU04aA65se1mhd/If+2hQ==
X-Received: by 2002:adf:e544:0:b0:32d:82b4:1957 with SMTP id
 z4-20020adfe544000000b0032d82b41957mr22964679wrm.40.1699284927791; 
 Mon, 06 Nov 2023 07:35:27 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 m1-20020a056000180100b0031980783d78sm9737093wrh.54.2023.11.06.07.35.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:35:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Daan De Meyer <daan.j.demeyer@gmail.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH] Add class property to configure KVM device node to use
Date: Mon,  6 Nov 2023 16:35:25 +0100
Message-ID: <20231106153525.417950-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231021134015.1119597-1-daan.j.demeyer@gmail.com>
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


