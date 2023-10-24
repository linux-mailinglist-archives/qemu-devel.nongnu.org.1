Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9290B7D53CB
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 16:20:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvIGm-0006H5-97; Tue, 24 Oct 2023 10:20:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvIGk-0006GA-HI; Tue, 24 Oct 2023 10:20:30 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qvIGX-0007Np-8F; Tue, 24 Oct 2023 10:20:30 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4084f682d31so33484235e9.2; 
 Tue, 24 Oct 2023 07:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698157214; x=1698762014; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N/RTcnvN+s3qfbGL8IxZ3YpZboBFi25HRb3Ev7DIpus=;
 b=lKfqrhf7WYtKQUwUTnm+VSXGJ1y+6WldVN1P6oG18WL0ARRpWEFP2m3ljAXy4Dqor+
 npI7UoVy/JGu56HzFCk+s5VJ1fYmhOYQ8lsKJH5ijkeiXqy1Mm9/anaw9XEQXkbZHUDl
 5Ddn11VuoSO8YW2GECdxtnChj0NykBRs4JrBBP5TwuJcA4zP8OclLp85m+Rwxar5rGRm
 hOfCdxjElQ8frjobIsB47Tp+/HbR+lhjqTLd/RATvSdi2VJvXukICpzCEazO4SAD/DTf
 Jv12QyHJuKs967AdC59TUrUeVTSkWNPWfXnNx7DdVq9Dp1tzfJtGoMYqWpQph/RAHf3v
 mJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698157214; x=1698762014;
 h=content-transfer-encoding:in-reply-to:organization:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N/RTcnvN+s3qfbGL8IxZ3YpZboBFi25HRb3Ev7DIpus=;
 b=K285sTPvdCtFuo7SUr3XUPkc6SR5tlhCFBJVoA9Fz4xxhBSY+YFiBrwDX371QV72zH
 CEB/OXGYDkDrLLBu9hXTReTfEaloW8G2lQJm5PgW5rW3c136J1k8NeKjCrxGjcCOqe4b
 /8o9oIsTJsKSiuFyeNj/DTbNhMUOR0ED1oQLnlF30euIMqFkryD7ff2nLhytCuvCDSD3
 wOyj11QhGqYJa6azuyh3iNulQOhy8/p3Ybzk/LoJxGP/oJBYBzh4EPJRASeZrJLgrvxH
 7i1LCwQbrR6DeXtF4lBTJescJU5QKJfJ9UdTN2m1RglrNgD7Ftn2alkTZry9rGnraZTw
 gszQ==
X-Gm-Message-State: AOJu0Yw+cozCI7jyIcIJe+yRTrO9nRjHltGKB40p30I7AXNWuH7/6QQD
 bV94JxAMnn3Nl4n72eoakSU=
X-Google-Smtp-Source: AGHT+IEyITPkgMCMhYLgEPjPPOpjFI74iF5+LpLQdanMOxh59eFvYc4PmD1+hbF9zetlTx+c01olxg==
X-Received: by 2002:a05:600c:5254:b0:405:2d23:16d9 with SMTP id
 fc20-20020a05600c525400b004052d2316d9mr9323630wmb.21.1698157214277; 
 Tue, 24 Oct 2023 07:20:14 -0700 (PDT)
Received: from [192.168.6.66] (54-240-197-238.amazon.com. [54.240.197.238])
 by smtp.gmail.com with ESMTPSA id
 p12-20020a05600c358c00b00401b242e2e6sm17039468wmq.47.2023.10.24.07.20.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Oct 2023 07:20:13 -0700 (PDT)
From: Paul Durrant <xadimgnik@gmail.com>
X-Google-Original-From: Paul Durrant <paul@xen.org>
Message-ID: <c18439ca-c9ae-4567-bbcf-dffe6f7b72e3@xen.org>
Date: Tue, 24 Oct 2023 15:20:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/12] hw/xen: add support for Xen primary console in
 emulated mode
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Marcelo Tosatti
 <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org
References: <20231016151909.22133-1-dwmw2@infradead.org>
 <20231016151909.22133-13-dwmw2@infradead.org>
Organization: Xen Project
In-Reply-To: <20231016151909.22133-13-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 16/10/2023 16:19, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The primary console is special because the toolstack maps a page at a
> fixed GFN and also allocates the guest-side event channel. Add support
> for that in emulated mode, so that we can have a primary console.
> 
> Add a *very* rudimentary stub of foriegnmem ops for emulated mode, which
> supports literally nothing except a single-page mapping of the console
> page. This might as well have been a hack in the xen_console driver, but
> this way at least the special-casing is kept within the Xen emulation
> code, and it gives us a hook for a more complete implementation if/when
> we ever do need one.
> 
Why can't you map the console page via the grant table like the xenstore 
page?

   Paul


