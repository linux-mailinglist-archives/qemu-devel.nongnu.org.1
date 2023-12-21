Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A4DE81BD24
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 18:24:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGMjj-0001M0-V1; Thu, 21 Dec 2023 12:21:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMje-0001C7-Rm
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:21:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGMjd-0004rq-51
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 12:21:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703179284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=EkBm1m7mVFYtO+CM3dlvhWOWQspP7J1vV98+4FZ5d4IoyR5ZZ7LchCoz3xP3iTVinOo7Yc
 g4KbC0gTy//FO4X7iEB7MX3YkqNr3Hn2whcIwIOr86a1cv8Noc4E9GSRAoc748SBm8xPX6
 O9dvcKMK7OP9EL3ukN3nxhckgXNkKKk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-CpMZgXXWNKezGqlNjV-twQ-1; Thu, 21 Dec 2023 12:21:23 -0500
X-MC-Unique: CpMZgXXWNKezGqlNjV-twQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a1b06d1bea7so50253666b.0
 for <qemu-devel@nongnu.org>; Thu, 21 Dec 2023 09:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703179281; x=1703784081;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=NYqXq4LsmW4HCpIXXeaMbDV7Kv6G40het0DRQhfj71l/nkoWa1omJ8pyGPYfbWsClj
 mnlb9ak+saUWOoV+PfBXTP8COo/qWWNM/L7vOn40HxKWaSV5l9hjqxypU4vFQN5XaOt9
 2fkoN4yHJyuoqzIan1q2NqJVS6JrNAj+WyEIq95aohxk4vXaZo0gQ9c/gQj2rpr41wmV
 QQN7xyqUzHUT9WJjdpAzIKm4i4hIDv3ESr4RlIIw69713nThsRTFtFA7XHDBrXfYtddj
 yqVmOr1Da6q537enJc10yqmKBQnY1E8x80oy/zK9Ey6FwJeUp5lYtgd2nQVzt/uhAntk
 mymQ==
X-Gm-Message-State: AOJu0YzvtSIL8p13o6wJ9tjIqpDfJO6mDZYqtaRuT1I996dWpQCNbzNg
 BDmBt82maN12yr+jYWAxGhSgwq0O34Yb1nA+JuNOUAvDWKdAupXSMIXeDK63tdsBU+i8hDSp7lN
 w8A2dRl+LSC3Be6rMjdt6LiKq1I5vvog=
X-Received: by 2002:a17:906:5a98:b0:a23:91fb:3d8 with SMTP id
 l24-20020a1709065a9800b00a2391fb03d8mr61070ejq.76.1703179281509; 
 Thu, 21 Dec 2023 09:21:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFIzBVyeIn6NHhuhNKKtFfUbYJ/8cYk5xM+HV4aG3mHx+ts3amAq6k8jVEfsx8du/1Quf5VeA==
X-Received: by 2002:a17:906:5a98:b0:a23:91fb:3d8 with SMTP id
 l24-20020a1709065a9800b00a2391fb03d8mr61064ejq.76.1703179281254; 
 Thu, 21 Dec 2023 09:21:21 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 d17-20020a170906345100b00a26af0a6845sm327413ejb.9.2023.12.21.09.21.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Dec 2023 09:21:20 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Michael Brown <mcb30@ipxe.org>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH v2] target/i386: Fix physical address truncation
Date: Thu, 21 Dec 2023 18:21:18 +0100
Message-ID: <20231221172118.59724-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0102018c8d11471f-9a6d73eb-0c34-4f61-8d37-5a4418f9e0d7-000000@eu-west-1.amazonses.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
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


