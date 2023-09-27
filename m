Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 19FC47B0139
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 12:04:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlRP9-0002ZN-M3; Wed, 27 Sep 2023 06:04:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlRP7-0002Ya-2Q
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:04:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlRP5-000371-Om
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:04:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695809062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=YXBNjXlXpPZLQYGNCeV+d0GTmVFb7O3FGlG9CRd7j9edQMOfhnN1tUyptoM9A96WchvBC8
 iNMxnra/7onkOYVhwniVbSte/kQ0CXC//CjHCsk32zUC3obYB//yMNFzOxpiDGuvS2PAEG
 JvRz1YcjO0Bg1Ms102b+sV29Di1QAgU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-hgQa3AwxPw2jUGVIEj9GCw-1; Wed, 27 Sep 2023 06:04:21 -0400
X-MC-Unique: hgQa3AwxPw2jUGVIEj9GCw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9a9f282713fso891734066b.3
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 03:04:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695809059; x=1696413859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=ePKlA56l7D+X6/dXXqA4OFU2CzuPUrcj7z79okhfQ/Q+PPlxvMvUKwXqAjtkgRtKcU
 1v7mCxIsEHlJzQsCx2qYd9b41wrepf2NIPxbYE1cbJuB/mt9hUBnDiPUEzZ0mY0s32rN
 CQ3Hf4mKZMmMTXk/WAXYFRi2dV90dH4a4IZOUeERLBQhlu7eojczuaYyrllgmMHyKWtX
 rTF+m7eu7ANqNaI+ylFu4HjvuqVfjWQzBdPsfZJAlMyjjxwX28VeGF8LhEDI+Log+ySN
 Slh5MV04v/RHC1YIjEMgL7hC2JViQst69YY6wESvOhlVjmBeJyumRgx4tJL4PzbjN38B
 VKJg==
X-Gm-Message-State: AOJu0YwCOsdvNyDJnoRrTyzN1SpqJv0pNZrHYgFTJdASSuiV55/5YO77
 L/LJpnfNeMhZuqVGvvn77TxlR74CKT6u8f1V023ERNAYekrlSWGIzHo8TjNeiqsjtG/C+07/QUP
 nVQ+ViQ0Jnxesl+uShi/Uk30=
X-Received: by 2002:a17:906:74d7:b0:9ae:381a:6c55 with SMTP id
 z23-20020a17090674d700b009ae381a6c55mr1378298ejl.15.1695809059653; 
 Wed, 27 Sep 2023 03:04:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFmN02eFnLazgdLvCsE4aIpvv85cQAxc2Mn7LvlaQAew+BPjDmZY6V28rBlKlBRI5vbfcbM8g==
X-Received: by 2002:a17:906:74d7:b0:9ae:381a:6c55 with SMTP id
 z23-20020a17090674d700b009ae381a6c55mr1378279ejl.15.1695809059339; 
 Wed, 27 Sep 2023 03:04:19 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 cb25-20020a170906a45900b009ad778a68c5sm9112500ejb.60.2023.09.27.03.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 03:04:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org,
	kvm@vger.kernel.org
Subject: Re: [PATCH] accel/kvm/kvm-all: Handle register access errors
Date: Wed, 27 Sep 2023 12:04:17 +0200
Message-ID: <20230927100417.792427-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20221201102728.69751-1-akihiko.odaki@daynix.com>
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


