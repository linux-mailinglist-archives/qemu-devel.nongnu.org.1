Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0007170F680
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 14:32:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1nfH-0006PH-0q; Wed, 24 May 2023 08:32:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1nez-0006Nu-0k
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:32:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q1nex-0002h4-J8
 for qemu-devel@nongnu.org; Wed, 24 May 2023 08:32:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684931524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=JacH6hIXwJqAUfqMMpy7Va+Ep4F0Z0F1cT30jQZVq76yUC3WTHjoCE8zbIzOYbIAExkIGb
 TaEfptuuyoiS3uah49+yn+pY2GQZmYXipnVMMjrBHNNr9CBWdm6aSu+aTKdWTTIZyvb4Cx
 KL5oP/HNSON/PzkdyCCJOkWCT//uJ1s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-XjZeDW5INiewT8EYgkRr_w-1; Wed, 24 May 2023 08:32:03 -0400
X-MC-Unique: XjZeDW5INiewT8EYgkRr_w-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f60162f7fcso3535765e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 05:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684931521; x=1687523521;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=eqK68vo1FmWHrkMu47t7oQrb+1IZSLJFcyJQeTXLy2VbYapB/FQ3ar64EgSTcUJipf
 fzWVdyV85JusHyD1gTjtuPMQOG+YYaI5Lk13epxPHVzbWzqKppzgfRm8tbsvWfAK4hEf
 0RV2wvRTMGOaKDvzC6wtr7EAIJgMwqRZuc8Nsunh1t7Jf/xVR2AfLKz7rZovXF6MMQTb
 xwvXEL+lRwWTGEmVckW817lq/WuLTDQv5a7Tbd917VF1V4IP4kWcbUeXx4lkHxPZX9JC
 UMZfODhRwT91VH6XcpVltg3X9JD23o61mHtoFRyaKcHWaYf8gKBNR/fU27NdkrB5XqiA
 bi5Q==
X-Gm-Message-State: AC+VfDzJNjNFPPmGavMzQ571EqNZnyvXBm1XH+ty49ykuv9fEDRVo5gP
 XPH03W7HGkjncoqseedwsjc+zhWFqOPub+K2Zz4nwtGCJ9HgUFq8Y0NlJ+diBaFF+NRIEWfq9by
 QAAO5XCgZQscj3N+N3Dua2zatFw==
X-Received: by 2002:a7b:cb58:0:b0:3f6:113a:2023 with SMTP id
 v24-20020a7bcb58000000b003f6113a2023mr2584766wmj.12.1684931521827; 
 Wed, 24 May 2023 05:32:01 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5WuEi0Kfgb6wtrJdkKPbZbBrdf/cC7Tr8fzFE/TDbGoXE1wAUhHcSgrXc5zGZZStHu1P0gvg==
X-Received: by 2002:a7b:cb58:0:b0:3f6:113a:2023 with SMTP id
 v24-20020a7bcb58000000b003f6113a2023mr2584745wmj.12.1684931521503; 
 Wed, 24 May 2023 05:32:01 -0700 (PDT)
Received: from [192.168.1.72] ([2001:b07:add:ec09:c399:bc87:7b6c:fb2a])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a7bc7ca000000b003f602e2b653sm2205216wmk.28.2023.05.24.05.32.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 05:32:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] meson: Adjust check for __int128_t
Date: Wed, 24 May 2023 14:31:56 +0200
Message-Id: <20230524123156.105360-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523223844.719056-1-richard.henderson@linaro.org>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


