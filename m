Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E0647D1254
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 17:13:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtrAz-0007qh-Hn; Fri, 20 Oct 2023 11:12:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1qtrAw-0007qD-0K
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:12:34 -0400
Received: from mail-lj1-x22b.google.com ([2a00:1450:4864:20::22b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1qtrAr-0003aj-Lh
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 11:12:33 -0400
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c515527310so13512151fa.2
 for <qemu-devel@nongnu.org>; Fri, 20 Oct 2023 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1697814745; x=1698419545;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=o46mZAMXYEATMgyz+VCK/2YGI2WnuaUImMyo8ONU7CU=;
 b=bF780lWubUCxVp32x+8Ncv1LaE3TEHETRHZcr4RIed9ws9hjdPePobiZ63fNNF6zn5
 AUUiGbc8ZRdeF619IYD5QSgKOm1I+yFFQDBMxR20KcC20OyW7ab3djd1A2YZD2N0w2dg
 nmCyVwhDmiIQi4pl60QslYxM8fdtE4yoZQsh5o8Dt6XPkFSTy/Lq89a4fvqQMB2oKDJz
 57yxeHauQytJNrmJO6VVd78AZUlXP6ALpkc52BK7zVzJa5vvLBAsoPIR7KFFukKKBHFK
 YcI7lXz4N4RL7G8SBvogeQxBng2rOJRPLT50c1weuGDNnM7Gz+EDUTgyJhrQAunZKZ7U
 lv9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697814745; x=1698419545;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o46mZAMXYEATMgyz+VCK/2YGI2WnuaUImMyo8ONU7CU=;
 b=VvY9tW3EwGOy8kLJfJwt8DT5Yo/l51NsT8rBHsOgYksKvOeHbLenPIcU2RgzSPGk35
 1Nkj4PmL5H3Zfbh8f82MggQg4hnAfQT2QekgnmCUtPHUkghC6f7mWIEfKX5KJ5fwNO3S
 ogdevOOMyxBcDF8QrV/1L6ygaicaNcJt9+YyBXbVhRE0LDPQFC2KxOqkkhDvrUgxLuz1
 cjNguSnyPB0xOyq0puuOCz67Z6Iq38AtFMeZkOK22jaQ17offbh5voDyGb1YWV9IMuPj
 OKKi81SKl6J1v57dZFdC0DM0vY3nlh29DffoBOEtiUe4b/Vo7nVz0kE5DOHz+K3yPCAb
 ZfAg==
X-Gm-Message-State: AOJu0YxPp7EI0LkR2bwbmlvxBslOW2N9BUJYq/IVfNA3G+j9kHxVUIA8
 ZnuxTjEKOT+4C00+UH4ON85bNnOwYSDPT4N5OEDnJw==
X-Google-Smtp-Source: AGHT+IEGcGufqOGQSWPavROXDzFUNfgyLlReNPNAavlxsv9nP615NOwXohSacJzYzmL/5dNnVM72lLN58gbcpx+mRZk=
X-Received: by 2002:a2e:8849:0:b0:2c5:23e3:ed11 with SMTP id
 z9-20020a2e8849000000b002c523e3ed11mr1573541ljj.30.1697814745259; Fri, 20 Oct
 2023 08:12:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230922140914.13906-1-phil@philjordan.eu>
 <20230922140914.13906-3-phil@philjordan.eu>
 <ZSLzq33DgMNYBsQT@roolebo.dev>
 <CAAibmn35JypPWfUophMgONTkgbYFvaaRhuD9+1kif9EOFx9HxQ@mail.gmail.com>
 <ZSMAr3hhxJryGpya@roolebo.dev>
 <CAAibmn3cMjnNWsQs8yCetc__Kr+ujn6Gn_ohGubVA3hCQbBy1w@mail.gmail.com>
 <CAGCz3vu=sX1m4PJiOvtTBza4iNUy6Hj+AtSAFi33zJ=dz_r7UA@mail.gmail.com>
In-Reply-To: <CAGCz3vu=sX1m4PJiOvtTBza4iNUy6Hj+AtSAFi33zJ=dz_r7UA@mail.gmail.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Fri, 20 Oct 2023 17:12:13 +0200
Message-ID: <CAGCz3vt2VB9i8+o-qFPpDptu81p3r00-TKfCV3O+=dQ0r3d88w@mail.gmail.com>
Subject: Re: [PATCH 2/3] i386: hvf: In kick_vcpu use hv_vcpu_interrupt to
 force exit
To: Phil Dennis-Jordan <phil@philjordan.eu>
Cc: Roman Bolshakov <roman@roolebo.dev>, qemu-devel@nongnu.org, dirty@apple.com,
 rbolshakov@ddn.com, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: neutral client-ip=2a00:1450:4864:20::22b;
 envelope-from=lists@philjordan.eu; helo=mail-lj1-x22b.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

Hi Roman, hi Paolo,

Just an update on my investigation of the hv_vcpu_run ->
hv_vcpu_run_until issue. The graphical issues with the Windows XP VM
appear to be caused by the dirty memory page system not working as
expected. The emulated (Cirrus) VGA adapter uses dirty page tracking
to perform partial screen updates, so when pages aren't marked as
dirty, they don't get updated on the host console.

This got me digging into how dirty memory tracking is actually
implemented in the Qemu hvf backend, and basically, it should never
have worked in the first place. When we get a write fault, the code
marks the *whole* 'logged' memory range as writable rather than just
the page that's just been dirtied. It just so happens that hv_vcpu_run
was causing EPT fault exits on those pages even after marking them
writable (?), and hv_vcpu_run_until() no longer does that. So
basically, this has been a Qemu bug masked by undesirable
hv_vcpu_run() behaviour. I'll start putting together a fix for this.

I'm also hoping to settle the hv_vcpu_interrupt() race condition
question empirically - if we can avoid the complicated signal/vmexit
race avoidance logic with atomic flags, that will make the code rather
simpler.

Phil

