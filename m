Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 882207CDED6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 16:14:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt7Is-0003ZO-5j; Wed, 18 Oct 2023 10:13:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt7Ip-0003L7-K3
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:13:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qt7In-0004zn-RG
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 10:13:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697638416;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4oYaF9loHTbYp00Wu0cUHGGD/JvBxQRB/RcpyJE1WZA=;
 b=ZSYXNo3WmzIfRa6CocCcITyPvkdnoxhk2rpr5ydcOlcT8cFzC6afj6TuIJl957M2toBmfg
 O5oe41ZvNkcy37V9/QV3dkoIsdt71bUZCevZJJUruBJx0a5U8URD2NhpG6w3OtYFiS6zjZ
 Uboz5aPqz8SOt/cMXkwdcnIWA+8tETk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-2S3w4MZTPeO7zyPkG33goQ-1; Wed, 18 Oct 2023 10:13:35 -0400
X-MC-Unique: 2S3w4MZTPeO7zyPkG33goQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-408374a3d6bso8114645e9.0
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 07:13:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697638414; x=1698243214;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4oYaF9loHTbYp00Wu0cUHGGD/JvBxQRB/RcpyJE1WZA=;
 b=xL+hrZwKkygFwiefVtqmSzwqDs9JGaib+ssge7bmcudIMxcRP2uAGSXlL/JLziA83D
 c263Dms6i6FH/SmVAl3ZPr5UcaATRCa6o3MUgbxORTC6xNadAxwau60cHg3BLElYcFVt
 DqUcIZSs005gI3TXCSUTszxxKTelwF2T91VFxqJ19BZtmbZkbg3sP0VginnjT7L+Fgbu
 RNd9Y1LXKe2KNbdWpiHSxrsegRzJPHQs/SeRH3ZgFmfrmp0Q7KyyeHCm9DyxjrY/Xhvx
 jdS0QCaAHcQaiJRuymmSArn4V/Nf0q3ZfccBSYOZjjZjpj4U4N/dZzF3lm+XhxOt6Uy3
 +YGQ==
X-Gm-Message-State: AOJu0YxwA2gfq9161FjEWJLjiUzIB0w/7E399L1JoNvFew8u4Hp61WbR
 cYoqt7/P0895E/AzyfeTyhj4zbrefw4EG+wm2yYlLwJgI+qiw0aIU97rIuF6qhLR6yzXwemqLDz
 w8ax3+EJNzGTfEys=
X-Received: by 2002:a05:600c:a47:b0:405:4a78:a890 with SMTP id
 c7-20020a05600c0a4700b004054a78a890mr4209618wmq.8.1697638414135; 
 Wed, 18 Oct 2023 07:13:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqB0NpAsrH4qlAhLzf1jBOBf2IbRu2SK6W9Ja3A+VWznHqDnZWxhJzDnH1XFkpA472+IdM5g==
X-Received: by 2002:a05:600c:a47:b0:405:4a78:a890 with SMTP id
 c7-20020a05600c0a4700b004054a78a890mr4209597wmq.8.1697638413846; 
 Wed, 18 Oct 2023 07:13:33 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 bh9-20020a05600c3d0900b003feae747ff2sm1787500wmb.35.2023.10.18.07.13.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 07:13:33 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Leonardo Bras
 <leobras@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Daniel
 P . =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Alex =?utf-8?Q?Benn?=
 =?utf-8?Q?=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 02/11] tests/qtest: Introduce qtest_init_with_env
In-Reply-To: <20231018140736.3618-3-farosas@suse.de> (Fabiano Rosas's message
 of "Wed, 18 Oct 2023 11:07:27 -0300")
References: <20231018140736.3618-1-farosas@suse.de>
 <20231018140736.3618-3-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Wed, 18 Oct 2023 16:13:32 +0200
Message-ID: <87il7481df.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> Add a version of qtest_init() that takes an environment variable
> containing the path of the QEMU binary. This allows tests to use more
> than one QEMU binary.
>
> If no variable is provided or the environment variable does not exist,
> that is not an error. Fallback to using QTEST_QEMU_BINARY.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Juan Quintela <quintela@redhat.com>

But I need that thomas or someone else also agrees.


