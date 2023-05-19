Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7131370973F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 14:32:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzzG3-0007pB-8R; Fri, 19 May 2023 08:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1pzzFy-0007nv-Gm
 for qemu-devel@nongnu.org; Fri, 19 May 2023 08:30:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aharivel@redhat.com>)
 id 1pzzFp-0002uP-HE
 for qemu-devel@nongnu.org; Fri, 19 May 2023 08:30:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684499433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6ef3NpjL9CBrVCeiGGJq6blDpDcsiBb0k9lm+Fss2RA=;
 b=Cb0D6Pb7Q8mllTUQT0Lc9XE9CxJtuH3goO71xJxBGKuCwzCh/3AC0tn67vPN8H1MWcQv1P
 02wdVV72aCC3I7BZpyvhm7/JVAEwAOxnJAmlKcfwJA1d1X0qKatLYZ5rkwe7MrZyWevVoG
 lONgFFfF3yCM/cS92BFUYEL93teeOk0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-lLzavXcYO7urM9vE2fX_9g-1; Fri, 19 May 2023 08:30:31 -0400
X-MC-Unique: lLzavXcYO7urM9vE2fX_9g-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-307bac4c949so2023338f8f.0
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 05:30:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684499430; x=1687091430;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6ef3NpjL9CBrVCeiGGJq6blDpDcsiBb0k9lm+Fss2RA=;
 b=XV7LjyjEftcEr6LiFD0FdZewZHL1LRpakPCaxFx22taPeHxSgTZyvDVmi+BiPkaJad
 j/Xex1DQfYag3l/t0W/d/sIvbTlVDD9A5h9z3FB1F90ZGJDMydZr0GXW+Evnpkw3d+Yx
 gKkIBEql5I/SFw4NcSRR9DWpJ2PMvZNxCInON7iaNGyyzChMwftD+jxwrr/oDo+l7/kn
 GiQ+41suzUSclbyXxJhkOEXMfRvybkGH96/HEqwrXmnHqg6a5r+w7Nx7VIZTy3kxjWHg
 AbQuWPjPqe2lKqots3GOtaqXyFybAKAQ3DJSC8+rtWpuiTDOf3PQYSjonpo44IrFdDpP
 rVGw==
X-Gm-Message-State: AC+VfDz+EHzcLtKI+2VDvEgnQYZ5YENWV1vbx0eej2Tv9ljsIT4v8dBZ
 8mR77BktMaW0K6apFm1oZ8JnTntBTtXmuThvY4o7Wb7eWplqtVFmbc9Ob5XQ4uD/BOL8e+6FZAu
 sPJJH2LIYcFmfp1w=
X-Received: by 2002:adf:ef42:0:b0:307:c0c4:108f with SMTP id
 c2-20020adfef42000000b00307c0c4108fmr1963596wrp.33.1684499430673; 
 Fri, 19 May 2023 05:30:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4bd1NM75SMmxcjqrS53W9jiTzLRqm9IK993JygPMfSbh+ZuD4rCSVee4YDyd4mXyM73xnGOA==
X-Received: by 2002:adf:ef42:0:b0:307:c0c4:108f with SMTP id
 c2-20020adfef42000000b00307c0c4108fmr1963572wrp.33.1684499430248; 
 Fri, 19 May 2023 05:30:30 -0700 (PDT)
Received: from localhost ([2a01:e0a:a9a:c460:ada2:6df5:d1b0:21e])
 by smtp.gmail.com with ESMTPSA id
 m39-20020a05600c3b2700b003f07ef4e3e0sm14428617wms.0.2023.05.19.05.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 05:30:29 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 May 2023 14:30:29 +0200
Message-Id: <CSQ97MRMICF6.5KCQEVGSYKFW@fedora>
Subject: Re: [RFC PATCH] Add support for RAPL MSRs in KVM/Qemu
From: "Anthony Harivel" <aharivel@redhat.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>, <pbonzini@redhat.com>, <mtosatti@redhat.com>
X-Mailer: aerc/0.13.0-123-g2937830491b5
References: <20230517130730.85469-1-aharivel@redhat.com>
 <d6118a9c-1e3f-4c29-520e-26562bbac600@linaro.org>
In-Reply-To: <d6118a9c-1e3f-4c29-520e-26562bbac600@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=aharivel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Philippe Mathieu-Daud=C3=A9, May 19, 2023 at 13:32:

Hi Philippe,

> > +/*
> > + * Package statistic
> > + * @ e_start: package energy counter before the sleep
> > + * @ e_end: package energy counter after the sleep
> > + * @ e_delta: delta of package energy counter
> > + * @ e_ratio: store the energy ratio of non-vCPU thread
> > + * @ nb_vcpu: number of vCPU running on this package
> > + */
> > +struct packge_energy_stat {
>
> "package"

My bad..
This will be corrected.

>
> > +    uint64_t e_start;
> > +    uint64_t e_end;
> > +    uint64_t e_delta;
> > +    uint64_t e_ratio;
> > +    unsigned int nb_vcpu;
> > +};
> > +
> > +typedef struct thread_stat thread_stat;
> > +typedef struct packge_energy_stat package_energy_stat;
> > +
> > +uint64_t read_msr(uint32_t reg, unsigned int cpu_id);
> > +void delta_ticks(thread_stat *thd_stat, int i);
> > +unsigned int get_maxcpus(unsigned int package_num);
> > +int read_thread_stat(struct thread_stat *thread, int pid, int index);
> > +pid_t *get_thread_ids(pid_t pid, int *num_threads);
> > +double get_ratio(package_energy_stat *pkg_stat,
> > +                        thread_stat *thd_stat,
> > +                        int maxticks, int i);
>
> Would prefixing these declarations with 'vmsr_' provide
> a clearer API? Otherwise, maybe this isn't the best header
> to declare them.

I agree with you this lack the prefixing you mention for better API clarity=
.=20
I will correct that.

Thanks !

> > +
> > +#endif /* VMSR_ENERGY_H */


