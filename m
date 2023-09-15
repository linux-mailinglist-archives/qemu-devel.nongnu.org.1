Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E42577A1DAB
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:48:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh7I3-0005do-NP; Fri, 15 Sep 2023 07:47:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qh7I1-0005bB-Ei
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qh7Hz-0004Lo-VX
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694778430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=T/MK1tB5cQEByC0xImgoCjW6VOQYSzKzjLE/QjMxozQmPBusCgGUPjHp8MOIsWUgQb+Bkx
 GWveKDi/goUH2cGCm+qLik8nNoznazUyTJKIo3pK76eyn8bDUColc9lBHFP3i8AQWlcKC6
 sqBaL0maZsrvKH0FC3hHc27OIbG71QI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-IC7cUsadNWWG-bxnloWb1Q-1; Fri, 15 Sep 2023 07:47:09 -0400
X-MC-Unique: IC7cUsadNWWG-bxnloWb1Q-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31fd48da316so1423845f8f.3
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 04:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694778428; x=1695383228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=d2VM12tlAeX7J8UzQfqhBZLvYyBNv7H/UDzZWZveOkSKq5jW0jy8YeRDVkMuPkDiGf
 BT4+CUkt96C67q4+Vek27Y6p7qXnLl1k+WABsRfyTxV1ZFmzjLQT3sU/hb8XMuSqIA7z
 j2TW+5VRLucqB2CTxqT607XiytCCI97H/wDhCDMY+mewdoU21F4XncSvnjNoQUAuN8Dn
 FNGWz9xQ4paDaGhZ/UBF9+9ohiD/QLI3A3hoNBZ1Y5HXp8CUIK7XyHsVrDIH2/vhLZEo
 0NVxir4beLiznL0mXtsT+jc4GJnci7BBHKr5+dkQP+Er+/6NJEctBN6ooxVDxdCDnAkP
 nRXQ==
X-Gm-Message-State: AOJu0Yz0MQyurRX/cdywQcxtyrafcOAMHN353SiArkkNrj1r7ypKrCRT
 Jwz1R7WG6yr5pTNVkpKMwOyUlW9OhbP4IwR8BbV6aobpGh9OPFGlOlcgmSu4K9YtPGzpulygin2
 AucefCKwqFylg3O8=
X-Received: by 2002:adf:f805:0:b0:31f:e5b8:469a with SMTP id
 s5-20020adff805000000b0031fe5b8469amr1110759wrp.16.1694778428047; 
 Fri, 15 Sep 2023 04:47:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP1jxgmaa5FuSOTYyIT/kmJiYbf36gfTMYbQTBiqqiufJO6CjyOfBzPhrdFtEVDE5raU4GGA==
X-Received: by 2002:adf:f805:0:b0:31f:e5b8:469a with SMTP id
 s5-20020adff805000000b0031fe5b8469amr1110743wrp.16.1694778427720; 
 Fri, 15 Sep 2023 04:47:07 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a5d4141000000b0031f300a4c26sm4197370wrq.93.2023.09.15.04.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 04:47:07 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 atishp@atishpatra.org, palmer@dabbelt.com, richard.henderson@linaro.org
Subject: Re: [PATCH v2] qemu/timer: Add host ticks function for RISC-V
Date: Fri, 15 Sep 2023 13:47:03 +0200
Message-ID: <20230915114703.1094513-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230911063223.742-1-zhiwei._5Fliu@linux.alibaba.com>
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


