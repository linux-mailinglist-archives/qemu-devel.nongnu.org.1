Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FCC7BFF1C
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 16:24:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqDeS-00011j-9L; Tue, 10 Oct 2023 10:24:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qqDeA-00010K-V4
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:23:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qqDe6-00086u-0j
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 10:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696947817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=bMTe8I1GVILY6uDmksPw0nOcjDmy3KdL9EHtGWWqKn6gWhnfM6WhuK9ecjecYi9Q5yM7Kr
 mT/XnDJy54bpPDP1hc7wXDKoAaDvXTbtN+I6xiMPTGi7Vyf/9/h/0hTa7Lo8Ac3hgUJT5W
 BZR7fD+KtDITte15ZvkYhEF9al5Qb0s=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-3gvximawOOqFPzBiIUPh0Q-1; Tue, 10 Oct 2023 10:23:30 -0400
X-MC-Unique: 3gvximawOOqFPzBiIUPh0Q-1
Received: by mail-ed1-f70.google.com with SMTP id
 4fb4d7f45d1cf-51d981149b5so4577144a12.3
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 07:23:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696947809; x=1697552609;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cyh9GNwkSeiWX8VVWJet6cmrStrv1Y1BhHYKMAKCy08=;
 b=qiMYIcCs8WLKmWvcUnCGvGJ7I1QF0Zhyd8QtrSyirS/Om6HXm72DbZatmCbvma0GD1
 KDwsM4ySRfSsHsp+cVmxxOqkACYN4RCLy+W0uxIBv+tGvGCoUS/WGbgU5PZyEdmg6T0f
 02yXa6mLhpiqey2+f6XLf8G+gDZeiUoALYzPIeM78G2B0QYfRot0aCVi5p0PuLQ1DAi+
 RevRZKzIf+ubqCKMd0PVvscsTNAwvToJ50dmZos/2NA+dLYUM3JRF4QJBEDtLFvP5vk9
 L8wrF/mTXr++TqvATuB+tZixRnCc1xVzYz/9AeYWalX/7xxM8GBhQlyrI+QiHyo34Q+p
 m63w==
X-Gm-Message-State: AOJu0YxZpSO4gV9597DbIhjHk3CmGYx9FBQ0kkQzMjppXZkN8AdqoaFO
 SFXPCwTF0HSNPfA9rEsbUZA+MyvNOXqwLdICRcqQrglArLfbppAX5xiMvfzsVEu1lbvj5xGIeR4
 DwhRu3tfFpBKDTTQ=
X-Received: by 2002:a05:6402:1357:b0:533:4a9a:b0e6 with SMTP id
 y23-20020a056402135700b005334a9ab0e6mr16877056edw.20.1696947809100; 
 Tue, 10 Oct 2023 07:23:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG1o+8tvERZWL9dJecF2S3JsOGyqi7e03f2hrGDcbO9YmlRcwQ3xim7ACk1HauoR64b88ZcEg==
X-Received: by 2002:a05:6402:1357:b0:533:4a9a:b0e6 with SMTP id
 y23-20020a056402135700b005334a9ab0e6mr16877048edw.20.1696947808804; 
 Tue, 10 Oct 2023 07:23:28 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:4783:a68:c1ee:15c5])
 by smtp.gmail.com with ESMTPSA id
 h17-20020aa7c611000000b00534c65fd0ebsm7720218edq.90.2023.10.10.07.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 07:23:28 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH] Revert "configure: Add workaround for ccache and clang"
Date: Tue, 10 Oct 2023 16:23:21 +0200
Message-ID: <20231010142321.264043-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009165113.498-1-luoyonggang@gmail.com>
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


