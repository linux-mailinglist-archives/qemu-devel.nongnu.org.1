Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B887DBDEF
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 17:32:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxVAq-0000hW-L2; Mon, 30 Oct 2023 12:31:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxVAf-0000fE-7W
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:31:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qxVAb-0002Hv-Vn
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 12:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698683474;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/9U9IZW9CzutpcypyTmEGcGcSmnRTpvX3q2EX0eDAg=;
 b=hxJO4JWnpXwp1dKtthzhYsTmCELBbaRH0e248Da7R/Lz1vk9ALUd2lnuKv3du+l9ZiGqsH
 Mh6smbmPrLCnNeJi+WLOmx/mlb5N8r5QqizGqXX1bR/GNiPUcyzSzqo+sZ15B/zflALPFV
 PKVKp6SExfXvmNTgipQjovEnqMZWrjk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-fpahheOpPJ6aZAzYSvS7iA-1; Mon, 30 Oct 2023 12:31:13 -0400
X-MC-Unique: fpahheOpPJ6aZAzYSvS7iA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-32f820c471fso896062f8f.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 09:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698683472; x=1699288272;
 h=content-transfer-encoding:mime-version:message-id:date:reply-to
 :user-agent:references:in-reply-to:subject:cc:to:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=w/9U9IZW9CzutpcypyTmEGcGcSmnRTpvX3q2EX0eDAg=;
 b=CsOf/JqiDXdxCDbrshBwfaDfX3QXhlcbGqt9eOtl9zIMZ4D7NBvA/M4XmsNPPliR4T
 sayvdKtwPq9Bi9PQrErgFu37QSTCNDv8VOLwpy3z+zunlwAtQL7zI//zdxZTNkbbWQ6u
 y5x/moZbv028TBekSDBKaWIGvVSwCyUno9XgjJZYSlKNu+zwtrNTVAIm6FLgaYLMpC6s
 btp7iuok94uoYsIQyB1803efyxT4/jtRfk5AqFrVd9ZOL7YFuai+p3lxYcnR53iNAsgc
 cUK2IvNkg5L2Px9FcM4v3BOMGUWHZJLFIrAHdR5De3J5yiAA7rnWZtvlSB6GsIuDMhNF
 BO8A==
X-Gm-Message-State: AOJu0Yx0LVcbm3m8adzpHcDHKay9dMWORPl/igJo5c8RPkV/ig3PT01F
 pA4W+VBltgqmkvYfaSX1F50OqHIEyEOpsW1PGCXCOlwg0V1K4n9HUeFSe1SYUX/FF1gtJ9JjwM+
 xA5pqklkaCO0BbvY=
X-Received: by 2002:a05:6000:4cf:b0:32d:87ca:7b0d with SMTP id
 h15-20020a05600004cf00b0032d87ca7b0dmr6957889wri.56.1698683472276; 
 Mon, 30 Oct 2023 09:31:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwm4HxOPSbWMTj8JkirS+hiq4QTfSxtfB73DeIlwW+H80fC3YShky7lOmGqJLomxIOQLJGVQ==
X-Received: by 2002:a05:6000:4cf:b0:32d:87ca:7b0d with SMTP id
 h15-20020a05600004cf00b0032d87ca7b0dmr6957873wri.56.1698683471923; 
 Mon, 30 Oct 2023 09:31:11 -0700 (PDT)
Received: from redhat.com (static-151-150-85-188.ipcom.comunitel.net.
 [188.85.150.151]) by smtp.gmail.com with ESMTPSA id
 bs27-20020a056000071b00b0032daf848f68sm5028588wrb.59.2023.10.30.09.31.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 09:31:11 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Dongli Zhang <dongli.zhang@oracle.com>
Cc: qemu-devel@nongnu.org,  philmd@linaro.org,  armbru@redhat.com,
 thuth@redhat.com,  kkostiuk@redhat.com,  berrange@redhat.com,
 dwmw@amazon.co.uk,  pbonzini@redhat.com,  joe.jin@oracle.com
Subject: Re: [PATCH v3 1/1] hmp: synchronize cpu state for lapic info
In-Reply-To: <20231026211938.162815-1-dongli.zhang@oracle.com> (Dongli Zhang's
 message of "Thu, 26 Oct 2023 14:19:38 -0700")
References: <20231026211938.162815-1-dongli.zhang@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Date: Mon, 30 Oct 2023 17:31:10 +0100
Message-ID: <87edhc9inl.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Dongli Zhang <dongli.zhang@oracle.com> wrote:
> While the default "info lapic" always synchronizes cpu state ...
>
> mon_get_cpu()
> -> mon_get_cpu_sync(mon, true)
>    -> cpu_synchronize_state(cpu)
>       -> ioctl KVM_GET_LAPIC (taking KVM as example)
>
> ... the cpu state is not synchronized when the apic-id is available as
> argument.
>
> The cpu state should be synchronized when apic-id is available. Otherwise
> the "info lapic <apic-id>" always returns stale data.
>
> Reference:
> https://lore.kernel.org/all/20211028155457.967291-19-berrange@redhat.com/
>
> Cc: Joe Jin <joe.jin@oracle.com>
> Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>

Reviewed-by: Juan Quintela <quintela@redhat.com>

But I wonder how I did get CC'd on this patch O:-)

Later, Juan.


