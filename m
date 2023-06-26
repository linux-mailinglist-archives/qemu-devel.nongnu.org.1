Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A879373DCFA
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 13:11:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDk84-0001jj-5h; Mon, 26 Jun 2023 07:11:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDk7z-0001jL-DZ
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:11:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDk7x-0008RL-UA
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 07:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687777884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=UlRCN4+b5auPev6kA9/iW+t4F5Jf885GeNHF9y1hF1qqr+6tvph3XfSPoHcP+KoKtqcAav
 xPoC60gJ0qfm0ncAUVBN2dCa1fIZ3yTqtzCAveeDUoA20KmhueFSfonv+ZodHgxdmaqRzv
 nBM9nDefIfKSJ9CY984iEPeU8PBJT+k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-ZxOnv_ZANzOUnfzsmLEuFA-1; Mon, 26 Jun 2023 07:11:23 -0400
X-MC-Unique: ZxOnv_ZANzOUnfzsmLEuFA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fb40d0623bso1061635e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 04:11:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687777882; x=1690369882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=TwnbM7QMMl5ZrjV8jDVyQQHZfVhm+ghP1nc0Ix8zMNMkXiW8K6mJVemwfklNjUGFjf
 lWEp+s2W/rWMe3RwDK4/P0wp6DdNeY1iip+Y7/gvWi7+mSelw2E6jxVPeyQsUnAeDbxT
 8y6hBoWztt8Lo3tAqTgrTWWQAFHSVv4UICg9KQakGJVQjpt976ZJFd0i/IhtVo7WBA8f
 Xwjr+NYbpd4fPAIP5RA8RhMqZleQMoS7K5e3Yulr6qEcX29egzyoaSWf6Kz5PkmAFucR
 WMqqAHUhzOvcDPlx3kj6eMMtmkmaidV9Aehu5keFNOhUzCQK54mRuikPcCcHz4Bw15VH
 iiqA==
X-Gm-Message-State: AC+VfDyNSVamEAC4n3NJbn3FMDXPOk+5/PFnaXivmdI8sGUkx61N98bQ
 i9IWL2CwaLXkF0z3xe0trYql0X4Q4sdrBSm1ms7hqIQI0TclMpzdov/2WRlzbeir9tpKlPsl8Yy
 NaHpsEaN4hY9Xfu8=
X-Received: by 2002:a7b:cd14:0:b0:3fa:82b4:fe3f with SMTP id
 f20-20020a7bcd14000000b003fa82b4fe3fmr6407692wmj.16.1687777882281; 
 Mon, 26 Jun 2023 04:11:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5ViYugVxVzhzcAkXhYlx9dXGnzNQbMofP2O6CD5MVXPY5RLIQQSs9rGM3O7g1baXzHoy9nDA==
X-Received: by 2002:a7b:cd14:0:b0:3fa:82b4:fe3f with SMTP id
 f20-20020a7bcd14000000b003fa82b4fe3fmr6407681wmj.16.1687777882023; 
 Mon, 26 Jun 2023 04:11:22 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 s6-20020a5d4ec6000000b0030ae849c70csm7061362wrv.37.2023.06.26.04.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 04:11:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: qemu-devel@nongnu.org,
	Chao Gao <chao.gao@intel.com>
Subject: Re: [PATCH] target/i386: Export MSR_ARCH_CAPABILITIES bits to guests
Date: Mon, 26 Jun 2023 13:11:11 +0200
Message-ID: <20230626111112.162807-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <63d85cc76d4cdc51e6c732478b81d8f13be11e5a.1687551881.git.pawan.kumar.gupta@linux.intel.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


