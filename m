Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 460E47BFF0E
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 16:21:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqDc2-0007kV-P2; Tue, 10 Oct 2023 10:21:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qqDc0-0007hS-Dc
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qqDby-0007p1-Rr
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:21:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696947683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=DR1UTYaGEmCDrKk5J9Z8A7auDcr9+M79YnHNGzE1sNwuqlLJTrgvvxjDGng0D2M+vbXRQH
 DFt0zHFank+zcqKMjQRVpk5RhcERite8MLvN05tXJ1kLCXp8+VJ7++0+P8J22GqMNlfM4S
 SIJHdj+nCHxzrIVL5xq6TO3L1Qocehs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-OcruwYz5P8moQqmTRMEO1w-1; Tue, 10 Oct 2023 10:21:12 -0400
X-MC-Unique: OcruwYz5P8moQqmTRMEO1w-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5344aaf2703so4663495a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 07:21:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696947669; x=1697552469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=jN5+j31/+syoiPLcUX3eT/5TYZZX7NuLC3oruAgHZXwBnOUlnXJIPJK47y4x8U4occ
 q8COXacgoEreeLVpOjCNyRZoJ6i3uUKUPZmzhaKdTgN6xes22UstK3XmUzEhjp/1mlj5
 HadHmplwEtFsEKsnC/IMIEYViLAtjvs9n8+koYgt84eincjsjGvG0ioIqq8IUCOt+pli
 36C+Qpj65e1AzJUSK3LceXeA00zw1fpcizw2pnwV3JXBmJRNW5UbIJqOr3z9whOloEVY
 2yKoVFd2HAZZTz46Eq5qMw/vyKjQSL9h0V370pfe01CkSWyaJDj1EuYyVMgJrC0j4Kgf
 TAKA==
X-Gm-Message-State: AOJu0YzkazbC4sQC9I9U1ixEYi1ara4dLdmfRo82VqKJc/upSe0VsVlg
 lkrrUEgIpUlSOWXRSaQK2kAZum/vxbs0IBFjv6PtG/BBiicg5ew5ftF1LMR6kGpsprn2ZZbNjdR
 G83ZxVl9u4iZF8cU=
X-Received: by 2002:a17:906:73cd:b0:9ae:329f:11c5 with SMTP id
 n13-20020a17090673cd00b009ae329f11c5mr17710257ejl.53.1696947669814; 
 Tue, 10 Oct 2023 07:21:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJKLIoisJ1qa6GNJdm0/NDOF98z46CQ9++teAkSOuuUWGnajo5+uY98mqKBIVoCANjYuJdhA==
X-Received: by 2002:a17:906:73cd:b0:9ae:329f:11c5 with SMTP id
 n13-20020a17090673cd00b009ae329f11c5mr17710241ejl.53.1696947669478; 
 Tue, 10 Oct 2023 07:21:09 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 gz19-20020a170906f2d300b009b2ca104988sm8488202ejb.98.2023.10.10.07.21.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 07:21:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Marcelo Tosatti <mtosatti@redhat.com>,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] targer/i386/cpu: Fix CPUID_HT exposure
Date: Tue, 10 Oct 2023 16:20:50 +0200
Message-ID: <20231010142050.263544-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010060539.210258-1-xiaoyao.li@intel.com>
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


