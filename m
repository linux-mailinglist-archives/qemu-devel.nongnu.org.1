Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8FA7F32B1
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 16:51:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5T1N-0007ZS-MU; Tue, 21 Nov 2023 10:50:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r5T1C-0007TE-Uw
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:50:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1r5T11-0001CZ-P2
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 10:50:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700581811;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=eczHE20JcvA/E5bPAIjFayeCygXRIlbr+o5kEmmj/9XuKoGUBOyi9LJkyIoqrwIsP/gTxB
 8QsOdvosLfsqJPSh/wRfY/avjmh00DK7cSqq9iW0YUP56EAfRltKy/sOMhubufrEIHQFQW
 0aP5G+VrD5cyIf3U4ThWrQYbgfA5M/4=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-Cs8EiTrOP6K1PMUHIlW10w-1; Tue, 21 Nov 2023 10:50:09 -0500
X-MC-Unique: Cs8EiTrOP6K1PMUHIlW10w-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1e9a324c12fso6288621fac.2
 for <qemu-devel@nongnu.org>; Tue, 21 Nov 2023 07:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700581809; x=1701186609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=K1M6oTnhje70C+gd2dkuxL3gm+/kXs5atnSYBoxBmmD3E3gt0hZKQn4vDXpJstqdLS
 oOQKh3W94qSJIYYc9mI8uk2HGnFRZiHghT5nMGxdu1RKWZcgSOYQnokQDZ0LBeCGYhlU
 XK+SZPsb4lAmEPhzOIu1gO+bra/I2UEaSWHAQPvojapB2QjqbWl+sTBm/7yC/d7xWDOt
 /0o6FKiFVZe4mUlO9iKitSwS6uwJhS9/pZQ+vmaZMsM974TwoxWATsWfSFKioFPMFWrL
 et8vwcyU3Y3atFiRMPC0aYT+33zVFrn53CPqj3Ttc5jgB8Sbp1bHhUET8U+C6fijDqZv
 /ZIA==
X-Gm-Message-State: AOJu0Yz35Be9IUtcsGswP2Xprcpi8GfOR4RlCAeMCMwXmcGoUxlaORRk
 2cwN+M9e6m2ClecKtCbw8v1PFQ8GsaEJot0W/oMS/G5qd+XltOlmBscGAksl849pCLgMgZou7gV
 kILyaThiv4gkw8iA=
X-Received: by 2002:a05:6870:a985:b0:1e9:a770:61eb with SMTP id
 ep5-20020a056870a98500b001e9a77061ebmr12673052oab.29.1700581809056; 
 Tue, 21 Nov 2023 07:50:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE/hMar+Ezm02hiXsDT7mD+EsCmITGug5Ayu9K/nmBUTl0ZKr7oVUQGeR6wUUnV3ohdenScGA==
X-Received: by 2002:a05:6870:a985:b0:1e9:a770:61eb with SMTP id
 ep5-20020a056870a98500b001e9a77061ebmr12673029oab.29.1700581808788; 
 Tue, 21 Nov 2023 07:50:08 -0800 (PST)
Received: from [10.201.49.108] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 14-20020ac8564e000000b00410ac0068d0sm3671552qtt.91.2023.11.21.07.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Nov 2023 07:50:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] configure: Make only once with pseudo-"in source tree"
 builds
Date: Tue, 21 Nov 2023 16:50:00 +0100
Message-ID: <20231121155001.32588-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231119101604.47325-1-akihiko.odaki@daynix.com>
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


