Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4F27CE9A5
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 23:00:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtDda-0007Tv-Fc; Wed, 18 Oct 2023 16:59:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtDdY-0007Th-Cq
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 16:59:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qtDdW-0004BV-SY
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 16:59:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697662765;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZFQKlyk2M/dzaJ7O9Fz1oEtIbqyqqMz0hdrREjKkaYI=;
 b=gctSEelpyscWb7c0KZBzU/JTp/dvAA78LwYHWsFfGNKzsuZ3R1+aWF3JPmo3WAWFLjS1pk
 otIoKPPuQ1MawBnanOvFVonzAdxPxZLsmVuzrNaDobcp0wlhImsSOf00s2Tw9o035N4O4E
 xgNTGgY0ROHiQQaSHbvO8gLn7IDFU8E=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-iK4uOz5XNf6XPYoRPKvI2A-1; Wed, 18 Oct 2023 16:59:24 -0400
X-MC-Unique: iK4uOz5XNf6XPYoRPKvI2A-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-41810d0d8c2so21122121cf.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 13:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697662763; x=1698267563;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFQKlyk2M/dzaJ7O9Fz1oEtIbqyqqMz0hdrREjKkaYI=;
 b=ihjQE5I1uKta4pJoZruvjB/VtaBtGLCPT24kSevD9g3UTGTl8DwKIatbRoQEgPuh7S
 PYgrZ2HWFr6Hja6YNOyE3jLiD+cKZQSx4hdscI7YXBh3w9ZhMBLQWcSEdyEZVuHzDKoa
 cfrKwUG0/otzidcuUpO+fDAGq6IeZXX2k7lFuhQZmulfawaDJmeQDuCTH5TGadzyLraA
 6QXun5+UXAJ0FNm5gJmfhpBB/xqLwByUJYfCzgvcd8+jSHLd7k/aYuy6mMVDgmaFKLja
 KiOwLBrx8ACW/BdzA9sXL7L2ynlBULhF8cUqYJgDP6quCy98CbASA6bXcXJOpVbMn3VG
 3T9A==
X-Gm-Message-State: AOJu0YzRggH76ei004Ptxk8Js2iBHFrEr2zpP+0nXST8z5IsOSWbsqrH
 g7V1CYXjfiH/63J+xM64fD0KI/+dfk89wN6B8iG5jweDetClZ2AL8eDDBYCPVdbgW5RBXoqVgcu
 +O3NdFuW360XMiiU=
X-Received: by 2002:a05:622a:6a4a:b0:41c:c83d:a94d with SMTP id
 ig10-20020a05622a6a4a00b0041cc83da94dmr44915qtb.5.1697662763546; 
 Wed, 18 Oct 2023 13:59:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKEOKtZ1eMc25EID7xTvseawUGwn0XJ72Ep0KhzCgw+RLLK8SuggwPIplUFUt/dA6BpXusEQ==
X-Received: by 2002:a05:622a:6a4a:b0:41c:c83d:a94d with SMTP id
 ig10-20020a05622a6a4a00b0041cc83da94dmr44903qtb.5.1697662763141; 
 Wed, 18 Oct 2023 13:59:23 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c19-20020ac84e13000000b00418122186ccsm235789qtw.12.2023.10.18.13.59.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 13:59:22 -0700 (PDT)
Date: Wed, 18 Oct 2023 16:59:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v4 02/12] tests/qtest: Introduce qtest_init_with_env
Message-ID: <ZTBHKOwCy72Bu5CE@x1n>
References: <20231018192741.25885-1-farosas@suse.de>
 <20231018192741.25885-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231018192741.25885-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Wed, Oct 18, 2023 at 04:27:31PM -0300, Fabiano Rosas wrote:
> +/**
> + * qtest_init_with_env:
> + * @var: Environment variable from where to take the QEMU binary
> + * @extra_args: Other arguments to pass to QEMU.  CAUTION: these
> + * arguments are subject to word splitting and shell evaluation.
> + *
> + * Like qtest_init(), but use a different environment variable for the
> + * QEMU binary.
> + *
> + * Returns: #QTestState instance.
> + */
> +QTestState *qtest_init_with_env(const char *var, const char *extra_args);

Another way to do is instead of passing over the env var, passing over
"char *qemu_bin" always, and take qtest_qemu_binary() as default.  Also
relevant to patch 1.  Not a big deal though, so can be done for later.

Thanks,

-- 
Peter Xu


