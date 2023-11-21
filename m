Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D72F7F32B2
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:51:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5T1N-0007Yk-Fj; Tue, 21 Nov 2023 10:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r5T1D-0007TF-2n
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:50:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r5T19-0001EA-O6
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700581815;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=iIJyslwpsQPsL2VbwDJ+56nI+ilCmjetPbRnw5EF1Ild09UdwT1657yGhxlV/9JCJ7AKXq
 u40ePAMe5RbFNXyOwrRWLyQof6UNTmubMUdYZUuL/az1Tl07vXWDhVDeYIx20vXRVXiiq2
 cum340XXytfTKFeRI2QpDTfMp4g5blo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-uGLLDEKyNiuAJMDfNsNVtQ-1; Tue, 21 Nov 2023 10:50:14 -0500
X-MC-Unique: uGLLDEKyNiuAJMDfNsNVtQ-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-77d5f5a50b9so33656785a.1
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 07:50:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700581812; x=1701186612;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=fownx9+Fyrr1Gh7ns7fpU6vRDUti09/wU5oVBUTDtpUUX3VcPtIBLsU1DrXfomJ9vO
 WVfXfnvWl1zS8U4pEQDudJnRBmp9C/porIAz99toJXqosLK3XsjxIjUXAbWHkeHtuuEp
 PcyKtTD5vEZY2tkKMJ6O19evmlYRykbgnhkr5zrytk9OoqxxoR4uIfegNauzOanbcTBU
 5IspRJnZexHLOCZPIKyD4Ia43aCQglLFqqZJcZYo7/MeXmAnK/el5w31jooVn4/azHFW
 7j1n9NaDv/qc226HDF5zSk4XuU1K3tpb1cFvqdhtTMcwwjpVQ9DwnkMbBcMlYJEmNtIM
 8QHw==
X-Gm-Message-State: AOJu0YwKB9R3E7EUv1dhRAbpq6Sn9Xh9g7Wt4L1cuVBfwupqpFe0JiEF
 zTOANe18vPwUHu1QWj3oj3Ixwcg43FjqsOhUx/Ndnm5JMWWkxGMJ4Z89sbVaS6S5TECPWAH26fF
 g/QQWsiWk7XTqv/0=
X-Received: by 2002:a05:620a:3194:b0:775:d031:a0c9 with SMTP id
 bi20-20020a05620a319400b00775d031a0c9mr13828664qkb.2.1700581812590; 
 Tue, 21 Nov 2023 07:50:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGTt/eQtf+l9yaTlKbG65chrnKS+dJ60jWUDe7kiTY+lsDlPFdEYf5Uj2ICNZQk4glfsixoDg==
X-Received: by 2002:a05:620a:3194:b0:775:d031:a0c9 with SMTP id
 bi20-20020a05620a319400b00775d031a0c9mr13828637qkb.2.1700581812340; 
 Tue, 21 Nov 2023 07:50:12 -0800 (PST)
Received: from [10.201.49.108] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 w18-20020a05620a0e9200b0076ef004f659sm3715021qkm.1.2023.11.21.07.50.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 07:50:11 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-stable@nongnu.org,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 "open list : S390 Virtio-ccw" <qemu-s390x@nongnu.org>
Subject: Re: [PATCH] avocado: fix Python invalid escape sequence
Date: Tue, 21 Nov 2023 16:50:01 +0100
Message-ID: <20231121155001.32588-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231116130022.1270356-1-marcandre.lureau@redhat.com>
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


