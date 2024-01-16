Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8839182EC9E
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 11:14:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPgRF-0001r6-Sx; Tue, 16 Jan 2024 05:12:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rPgRE-0001pu-5p
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:12:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rPgRC-000185-An
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 05:12:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705399972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=a6qwRel3byi+fyA956SEg4xX8GZakqxpl4q0KljLcjus5mO2HCXqASZNqSK2Y9bpc1AQt4
 M5OTf70ddMl+SsMZD8avFHVDeFJ+xp9ni9qTcamDx5uHZ60AkmxvwMRS+P+GjVtiic9XM1
 5fwVQXoyCRFxSXVklnM8//kIYxufghk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-E4caUEc9MpGYRoZBaAY7qg-1; Tue, 16 Jan 2024 05:12:51 -0500
X-MC-Unique: E4caUEc9MpGYRoZBaAY7qg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a2bc65005feso331022266b.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 02:12:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705399969; x=1706004769;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=i6lKt7i2EmPAJTo6B40MfaSlogKy9r4THGMPDk+Ldoy0jsIw9XsMUIKdcsqj+LmFMO
 yl0QN2sPe+BzwjDJtYiEtwmCZ3Vm3OAgrI5KUM1j8tXyBvB7Lkt5zZecC0qboTaBq/Yw
 Bp/IZ0j+0ALj7LAEoSRW5iVajOeCNiapZU5Yz8QVCRIHCjFZDvbYIWrNsl09xw7h9bwv
 tzXuOFFW/alvTj1Z6l2uCCQvFdN+V9Bz+EnDOP2tcKHOKyezorbD1oYyITy8lJ/Jl1F2
 DChowxPfPhu9SzdKvmWOlAd69BCA6EcDlGUPBvg86KxtaE8+YxhwdLfHBHzwys+o3Gku
 y/YA==
X-Gm-Message-State: AOJu0YwH9lm+xbO3ebdXP3F6ctByNYSxoD/zh7Bw+wYzQ1y2Iiwu6fIZ
 Tx1UzXCjP6ro6D4OShTzWIpxz8IXHTpyqy/ernHHOXh4QoN2Rc/GSpC2Dn4K3+6ewfn5+rSOcy3
 HM9pc5iSSUTXfwdBJda2wXKmtYK4QyHs=
X-Received: by 2002:a17:906:b192:b0:a28:c7bc:327c with SMTP id
 w18-20020a170906b19200b00a28c7bc327cmr3180497ejy.71.1705399969494; 
 Tue, 16 Jan 2024 02:12:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF2lKhDfPOKlApNhg7ar276AME2pc81ux0AgTGYOfDd/IS7POH7hJKSdioMV+oApZ/EnCz7pg==
X-Received: by 2002:a17:906:b192:b0:a28:c7bc:327c with SMTP id
 w18-20020a170906b19200b00a28c7bc327cmr3180491ejy.71.1705399969123; 
 Tue, 16 Jan 2024 02:12:49 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 q8-20020a170906360800b00a2bd52d2a84sm6260596ejb.200.2024.01.16.02.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 02:12:48 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <gaosong@loongson.cn>,
	qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu/osdep: Add huge page aligned support on LoongArch
 platform
Date: Tue, 16 Jan 2024 11:12:46 +0100
Message-ID: <20240116101246.9440-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240115073244.174155-1-maobibo@loongson.cn>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.531,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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


