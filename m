Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF8C727FEE
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 14:25:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7EhL-0008II-Ba; Thu, 08 Jun 2023 08:25:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q7EhJ-0008Hp-8D
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:25:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1q7EhE-0004Fc-D4
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 08:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686227094;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=euqbOz7Gc/VfG2+ekA4pYJ4dDhLAGvx60T1O0TpvnCyIFAmXbmJcl9034meYnjReYv7M8u
 C2u/Mb21mXKAZ5Iz5f9WfbUQRHTfP7UZE/AG9zkILWmsOHw7UYCX1+t4C3n/CWZRxoIYls
 oxA0sMNMiFCn6z6mZtbNv67Q6Gt/vZw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-wVZMrcmvPCm0icdFn7Q_bw-1; Thu, 08 Jun 2023 08:24:53 -0400
X-MC-Unique: wVZMrcmvPCm0icdFn7Q_bw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-977eabfc3ccso75518166b.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 05:24:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686227092; x=1688819092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=G8GuyxGWQGouNDicCTr86NqZ9ssmBK8stVkXtYPRQuzya70XJoWH+biG7C8pjxwZhx
 ysv+yrxkAv+Okr5BWPEmMsxnQZRNeoUK2kHn58QViYjQOYOl2fUSTdBr502ccC1moEDK
 3YQgl5fFjaXJxDreb379bUoCuU4GK1/W4o2VXj8IPbvu7bGrLyXTzgN4ETUKN8HRsR7n
 i+1PbgZtnLE5O9lS6YrbAaEUN+NchutingKWUA59dYExlDIbBc5F9ab9zYRZtcpzAvae
 u2pCo3zSufaS4u/CX96NJFbCnlwRsDxp35dA8oF+sTkpFw+jN/jysgNyCEb3xHvNICXG
 F1GA==
X-Gm-Message-State: AC+VfDz0+AHSTS6fg+GMd0wMTEcbBvWO+dPpPpZsJWMIBD0ixaSo4rF2
 Yf0JXMk5OQH5JwSYQ7dD1YXxH1Cq2mZw41o1K/P26zDcbqF2Wd7idmptETng4tc+bsDwr4LWs0A
 GUSiNgIVwA/cGKHg=
X-Received: by 2002:a17:907:7f2a:b0:966:1bf2:2af5 with SMTP id
 qf42-20020a1709077f2a00b009661bf22af5mr2086597ejc.22.1686227092617; 
 Thu, 08 Jun 2023 05:24:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5cbjEPnJx8LYNpohJp9xPfkKh5nP2U9c3J/hradbFa6vbQvvQtmwK74P5Vl6HmL/w2Ex2Ybw==
X-Received: by 2002:a17:907:7f2a:b0:966:1bf2:2af5 with SMTP id
 qf42-20020a1709077f2a00b009661bf22af5mr2086571ejc.22.1686227092220; 
 Thu, 08 Jun 2023 05:24:52 -0700 (PDT)
Received: from [192.168.122.1] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 n26-20020a1709065e1a00b00978897577c6sm631890eju.44.2023.06.08.05.24.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jun 2023 05:24:51 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 pbonzini@redhat.com, imammedo@redhat.com, peter.maydell@linaro.org,
 rad@semihalf.com, quic_llindhol@quicinc.com, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org, wangyanan55@huawei.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, bin.meng@windriver.com,
 thuth@redhat.com, lvivier@redhat.com, ajones@ventanamicro.com,
 berrange@redhat.com, dbarboza@ventanamicro.com, yihyu@redhat.com,
 shan.gavin@gmail.com
Subject: Re: [PATCH v5 0/3] NUMA: Apply cluster-NUMA-node boundary for aarch64
 and riscv machines
Date: Thu,  8 Jun 2023 14:24:50 +0200
Message-Id: <20230608122450.915545-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509002739.18388-1-gshan@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


