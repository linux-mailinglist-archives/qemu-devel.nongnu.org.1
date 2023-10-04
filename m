Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F707B80A6
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:19:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1mb-00033o-Tx; Wed, 04 Oct 2023 09:19:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qo1ma-00033f-LF
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:19:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qo1mY-0005h1-9c
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:19:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696425557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=YhGDXK2WT0t27BijUuPCmlmwiBS39LKBBe4QF6Z664KQ1PJ+I23u2b/Xy4P1NV7u6toXGQ
 ZCedyVYjUAMcFgn8qsatkfZhtjpH1FyfmnOifEJTi0MLqb+g6yhmHo27uC8ieo1zQnUidp
 7gvn4CKHAOYdUbEf8Binz9/ZIb2Pd5g=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-CUa_9tTHO22xn9nG_qA8RA-1; Wed, 04 Oct 2023 09:19:01 -0400
X-MC-Unique: CUa_9tTHO22xn9nG_qA8RA-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-538128e18e9so1909287a12.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 06:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696425540; x=1697030340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=L65XiomejHiESuH1E1YaVcME7hIea/JQcde+w7BcNiBWTEIZaBh3Rf/YO0PobNrwpM
 DdyyW4IeF1aMI09n1El+Vww+g758Z7GmKqrTKGwxuqxyrfAdaStxRui5Pw9XKZw4WyCP
 wIEDsvKhXdgFJXuyTM8l4JQNdUDEitpIrqdDuml9UbrviHuc2oRu0Hz8Aal297B4BQnz
 tl7issZyqSAA+dEqa9o0qEQ1lqj9y1a78yHKUvugP9jKVqL3Q5dN3HeZ3UX/oxqRSQX2
 hOLf2YFBA4SezXahyUfYMGXdtLVWu/ShsKVpWqDMdVsFeg10ZDcNfn4IjAVIrIn8jzN3
 gv9w==
X-Gm-Message-State: AOJu0Ywcp2hWEJb9Uk+Zj91wh2neyL1eN5LMVVnCyh31RZEZd7qLmZLs
 4oyOu3VBazE03dobqRo3TBLdth2q0Pfno+hAFGNrisaiy9NN75O9erZ70uX8elVqTo/LfOitNs+
 eJ0pdDzgxlmp5ySoUH181N+E=
X-Received: by 2002:aa7:c302:0:b0:533:97c:8414 with SMTP id
 l2-20020aa7c302000000b00533097c8414mr2148961edq.7.1696425539958; 
 Wed, 04 Oct 2023 06:18:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHorg/zTumYNaXW0P2IB6ez4lXonf/iuo8tnRsm4jzWxxYrEf4uyg5Cj/OP5u2Y2KeBPlOCkg==
X-Received: by 2002:aa7:c302:0:b0:533:97c:8414 with SMTP id
 l2-20020aa7c302000000b00533097c8414mr2148940edq.7.1696425539592; 
 Wed, 04 Oct 2023 06:18:59 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:2f4b:62da:3159:e077])
 by smtp.gmail.com with ESMTPSA id
 k17-20020aa7d8d1000000b00530bc7cf377sm2409422eds.12.2023.10.04.06.18.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 06:18:58 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] target/i386: Check for USER_ONLY definition instead of
 SOFTMMU one
Date: Wed,  4 Oct 2023 15:18:57 +0200
Message-ID: <20231004131857.160754-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004082239.27251-1-philmd@linaro.org>
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


