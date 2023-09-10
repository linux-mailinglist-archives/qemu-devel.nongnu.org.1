Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4F6799CD7
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 08:47:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfECL-0007YG-5T; Sun, 10 Sep 2023 02:45:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qfEC4-0007Xy-1X
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 02:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qfEC1-0006wz-28
 for qemu-devel@nongnu.org; Sun, 10 Sep 2023 02:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694328309;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=TKcFnyggKfaego0LhPeGCXZX0Ycv7mbJ7tJ4t38BVl8UuyO06v/3MbivPe+pAjlhCVzCHR
 lhV1nnbQb1Woa3FTRQ1kWKD3KQdroRhzN7CF1CEaQM0haytfe07718E+7OB3Vr4FjVHjva
 Zn9AnwYGkTRJIwXDYQNZwTa7KwFLm1U=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-12-niZP5VjnOByLTIZYXct-Jg-1; Sun, 10 Sep 2023 02:45:06 -0400
X-MC-Unique: niZP5VjnOByLTIZYXct-Jg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31dc8f0733dso2266468f8f.3
 for <qemu-devel@nongnu.org>; Sat, 09 Sep 2023 23:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694328305; x=1694933105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=sUg3FVq59VQNVzKMZmfgnoGxM4vdX4sX41OwPJiaMMIwLEwnLfgjV6gO0AXP7nHM++
 mh2O9s0S7D/kza82F4+jR5n9z0yyAPhM5nkZ3lXqkhCLJGQnUCJRubSq0WMejG1WhF5S
 +iLeGKBiNT0Yx2NA9Q+0szs3dMpHFcKF3PCe2mEesk0LqGdWhToJ4FFWHfYNaNStwGC0
 HlIIieI3sW2lBi1io67QduE/JS/Ou+qBTYpxGvCuAgft645EWbAx2YbFNK31XUVYhMpN
 jaFTJjIDqfy2GSp32TTZM548U/dOJYlmuQ+T9FEYfwKmPPlhDr8dWKsVpbw0X57LtIP8
 VuyQ==
X-Gm-Message-State: AOJu0Yy9+lMP1NoLKIWk25pLftK83aSKykJN3wf5YnsugiOM31K3bgrY
 i7dAWX7cIjAB6RCZojZszcVsBTs1Iyp/qdUHs2WLqdvJYm5680E0SdRtPGim0TCZyvwp1B9GhxR
 2P9ev1fwjBXT7pWmvSKGnOAk=
X-Received: by 2002:adf:f5cb:0:b0:31c:8c93:61e3 with SMTP id
 k11-20020adff5cb000000b0031c8c9361e3mr5133378wrp.60.1694328305545; 
 Sat, 09 Sep 2023 23:45:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG5gq54kE/H1O1UvLYByxIzWZgqkxU7xrlY/B1/kkt/EcPoam/Ef9KKCJlFvjPbutpUFshZsg==
X-Received: by 2002:adf:f5cb:0:b0:31c:8c93:61e3 with SMTP id
 k11-20020adff5cb000000b0031c8c9361e3mr5133365wrp.60.1694328305123; 
 Sat, 09 Sep 2023 23:45:05 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a05600001c300b0031f07d1edbcsm6580308wrx.77.2023.09.09.23.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 09 Sep 2023 23:45:03 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Jonathan Perkin <jonathan@perkin.org.uk>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] meson: Fix targetos match for illumos and Solaris.
Date: Sun, 10 Sep 2023 08:45:02 +0200
Message-ID: <20230910064502.621945-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZPtdxtum9UVPy58J@perkin.org.uk>
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


