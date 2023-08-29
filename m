Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA67778C9F7
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 18:54:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb1xr-0002oa-Fx; Tue, 29 Aug 2023 12:53:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qb1xo-0002nq-Vg
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:53:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qb1xm-0002zX-Cn
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 12:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693327989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cE5KHY6AA9R9iIZ08IYxO2tpMY4HUUWKT0xfywV3MHg=;
 b=MxXphrCNja2b9hkhRUGmG1FalTF/7yvIZ3qMmV66secgRWCIZykiIsmMHOeV8Ac7kowaXT
 euGE4NAHC7F0RWAf8xJwJePYHxs2uNNYi38zydL8a4lmL1eDH1qfOUtZHsuWzkj6ufvll9
 HooM5m8sGTOzlsV/rLt7JwOYkQ2k6IU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-raBQJDJTMZKh7hBw7n6vvg-1; Tue, 29 Aug 2023 12:53:08 -0400
X-MC-Unique: raBQJDJTMZKh7hBw7n6vvg-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-31c5c762f97so2991164f8f.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 09:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693327986; x=1693932786;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cE5KHY6AA9R9iIZ08IYxO2tpMY4HUUWKT0xfywV3MHg=;
 b=I7nVE5RH9yqbFjLMsC1WAudWSBrw0//scVfJm7E8cpiY7aWSeL/gHFVAZYCaFS5ULU
 ybfHwOqosEvILBXIeJcwr192MubTue6Yg13I2Er8dP4Lc78E8aIiLplQ1HdIeuUxlwwx
 ngGg0/rMagcyQ6Vr5D+77NEgLBLqNtxKtUthB6i4Mn8CVbjnqbAxO+HEXBJ6d4Ot/e60
 rg1NvyIbmYtul373xxjh2myPmRllZVV7LVHTJMz7+/YGfK3bnweas49FJt4djpo+bk0a
 NE1J72EIqaGNyrISGqoQKcczkDul7Yd6NG4zy6OV6dI4LgCzKRteSY5MAQs6vv9wbbQK
 y8WQ==
X-Gm-Message-State: AOJu0YwOkYdLCFGqATXcoXZE22rzCh9GxOOYoJTlXP0aUoTUEkJFyypQ
 5/1pR2xALsto54hKNrnlezrfG47OUUuFJLum4VyZShl0IEItNLPIXpG3fDZBeOIK5dp54blZmqm
 fm1ND3roMzWpRsatqswQWiN/iszqvNzQv9Oybp/Mm+yP8hdjBoRD447k2enY3RYTvLj/K0Tkd66
 4=
X-Received: by 2002:a5d:5102:0:b0:315:a1d5:a3d5 with SMTP id
 s2-20020a5d5102000000b00315a1d5a3d5mr23610970wrt.22.1693327986603; 
 Tue, 29 Aug 2023 09:53:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPvgTE0GafVxpKIPL0DHzyN6NdERsftcTuJa0VdE8NA96uwgBMh+3LzwxJYCFXzZLQwuDxOQ==
X-Received: by 2002:a5d:5102:0:b0:315:a1d5:a3d5 with SMTP id
 s2-20020a5d5102000000b00315a1d5a3d5mr23610957wrt.22.1693327986130; 
 Tue, 29 Aug 2023 09:53:06 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 y14-20020adfee0e000000b0031c56218984sm14188725wrn.104.2023.08.29.09.53.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 09:53:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] target/i386: reimplement fp2fp conversion instructions
Date: Tue, 29 Aug 2023 18:53:02 +0200
Message-ID: <20230829165304.114948-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

CVTPS2PD only loads a half-register for memory, unlike the other
operations under 0x0F 0x5A.  Therefore, it is unlike other
"unary" floating point operations, that load a full register
from memory in their packed incarnation.

To fix it, reimplement the four operations under 0x0F 0x5A
(CVTSS2SD, CVTSD2SS, CVTPS2PD, CVTPD2PS) individually.

Paolo

Paolo Bonzini (2):
  target/i386: generalize operand size "ph" for use in CVTPS2PD
  target/i386: fix memory operand size for CVTPS2PD

 target/i386/tcg/decode-new.c.inc | 20 +++++++++++++++-----
 target/i386/tcg/decode-new.h     |  2 +-
 target/i386/tcg/emit.c.inc       | 30 +++++++++++++++++++++++++-----
 3 files changed, 41 insertions(+), 11 deletions(-)

-- 
2.41.0


