Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C38DB8D7A40
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jun 2024 04:59:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sDxsm-0001DG-8z; Sun, 02 Jun 2024 22:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDxse-0000uk-Gk
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 22:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sDt9t-0000pM-LN
 for qemu-devel@nongnu.org; Sun, 02 Jun 2024 17:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717365272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U4ECqjVXffjOg0/v7j1YTUQn7WaQlZyvMmi41Udz+uU=;
 b=MhODJsRRzu4BOyE0T4CifpP07oWdtRdBeeH3r25XdBu6gace5htIaTOY7Dmw1v2JVHKOBI
 c/li5jSF6N9XnunAu1ACpgm1eSFgKe403UAJaVFRmH2p19FXskU5CSiNqyeAlwVbIDA+V4
 W7QWTz8CWZuRnCk3CAAzsvFyHn8ouDA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-GCYOw8AZPWyDKKVCNQmltw-1; Sun, 02 Jun 2024 17:54:30 -0400
X-MC-Unique: GCYOw8AZPWyDKKVCNQmltw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4212a20c447so17940835e9.3
 for <qemu-devel@nongnu.org>; Sun, 02 Jun 2024 14:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717365269; x=1717970069;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U4ECqjVXffjOg0/v7j1YTUQn7WaQlZyvMmi41Udz+uU=;
 b=YnykLhAWKnWgNA0IwN3bMpAIEEFtfjWLKmO0wA9wtMbqwpwRCu6gV34pq8J9eprauw
 Gp0f2vyPYI99FWO+GiU1TntRu6LgLzolBOqYtK4p1vfCSAswNAgQO4R2Yn9C5HRXls5f
 zM4BvSwb/YfY0NwGPIrhD5+9gQJ1LaGSq8ZGQ++SdWQUzK89UPWk0o3+rPjxabfg1SXM
 QvMQX3iiYuQ7LuOrbQnLqocWsHCZ6eKc3yMEk/pVXLkP5aPBFnQTyyTCdXyZi1kyNqRp
 ShUJW7Wk4RV91lRTaONcP40MxMQMrJIXnr3WNsiQYpn9EgDwermYUlrpjr2bOBxVUNpw
 K0kA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6kz2uKHs0rInYbXu9IrqSxLtXaEYfv06bGiu6oDMR/arNRMBJEvmLlZQqfF/mjZDeU/jYgri1W18p/xjinco1mOJDdeg=
X-Gm-Message-State: AOJu0Yz4puZnS7DqBVz6ca+nl2CTHrNj4X5J7yR+xtccZjSOuFQbw0sl
 Ip1jyEW4DwFIaI6aDS/5SprX/e59NIoiDIUEy20ciZC11chmFUMwHXa4OipDdNE2t93IQ7EUbwe
 sXsLlHSUU9LQXb1TQXTHYsORcLsY4fi+cYbNuCKWZXCN/t2pD0Shz
X-Received: by 2002:a05:600c:468f:b0:420:1125:dd79 with SMTP id
 5b1f17b1804b1-4212e0ade24mr60834195e9.31.1717365269609; 
 Sun, 02 Jun 2024 14:54:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyEVMoZD7tPXVQ6+xrVT/jfdCtxZsJMh7lPebp9vpIneGnqNLL/+66jG/7iFp/RcabPXD/Qw==
X-Received: by 2002:a05:600c:468f:b0:420:1125:dd79 with SMTP id
 5b1f17b1804b1-4212e0ade24mr60834055e9.31.1717365268911; 
 Sun, 02 Jun 2024 14:54:28 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:440:950b:d4e:f17a:17d8:5699])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35e4e29d4c9sm4241075f8f.85.2024.06.02.14.54.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jun 2024 14:54:28 -0700 (PDT)
Date: Sun, 2 Jun 2024 17:54:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, "Chen, Zide" <zide.chen@intel.com>,
 qemu-devel@nongnu.org, pbonzini@redhat.com, thuth@redhat.com,
 cfontana@suse.de, xiaoyao.li@intel.com, qemu-trivial@nongnu.org,
 seanjc@google.com
Subject: Re: [PATCH V2 0/3] improve -overcommit cpu-pm=on|off
Message-ID: <20240602175358-mutt-send-email-mst@kernel.org>
References: <20240524200017.150339-1-zide.chen@intel.com>
 <20240528112327.634e95a6@imammedo.users.ipa.redhat.com>
 <29944dba-7005-496d-81ff-1cbc77c67f15@intel.com>
 <20240529144634.40aa597f@imammedo.users.ipa.redhat.com>
 <898effa1-1a5b-42c0-9305-8db8d5febbf5@intel.com>
 <ZliFJyRhnSVlNOYQ@intel.com>
 <20240530164933.20e4e55d@imammedo.users.ipa.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240530164933.20e4e55d@imammedo.users.ipa.redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Thu, May 30, 2024 at 04:49:33PM +0200, Igor Mammedov wrote:
> On Thu, 30 May 2024 21:54:47 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
> 
> > Hi Zide,
> > 
> > On Wed, May 29, 2024 at 10:31:21AM -0700, Chen, Zide wrote:
> > > Date: Wed, 29 May 2024 10:31:21 -0700
> > > From: "Chen, Zide" <zide.chen@intel.com>
> > > Subject: Re: [PATCH V2 0/3] improve -overcommit cpu-pm=on|off
> > > 
> > > 
> > > 
> > > On 5/29/2024 5:46 AM, Igor Mammedov wrote:  
> > > > On Tue, 28 May 2024 11:16:59 -0700
> > > > "Chen, Zide" <zide.chen@intel.com> wrote:
> > > >   
> > > >> On 5/28/2024 2:23 AM, Igor Mammedov wrote:  
> > > >>> On Fri, 24 May 2024 13:00:14 -0700
> > > >>> Zide Chen <zide.chen@intel.com> wrote:
> > > >>>     
> > > >>>> Currently, if running "-overcommit cpu-pm=on" on hosts that don't
> > > >>>> have MWAIT support, the MWAIT/MONITOR feature is advertised to the
> > > >>>> guest and executing MWAIT/MONITOR on the guest triggers #UD.    
> > > >>>
> > > >>> this is missing proper description how do you trigger issue
> > > >>> with reproducer and detailed description why guest sees MWAIT
> > > >>> when it's not supported by host.    
> > > >>
> > > >> If "overcommit cpu-pm=on" and "-cpu host" are present, as shown in the  
> > > > it's bette to provide full QEMU CLI and host/guest kernels used and what
> > > > hardware was used if it's relevant so others can reproduce problem.  
> > > 
> > > I ever reproduced this on an older Intel Icelake machine, a
> > > Sapphire Rapids and a Sierra Forest, but I believe this is a x86 generic
> > > issue, not specific to particular models.
> > > 
> > > For the CLI, I think the only command line options that matter are
> > >  -overcommit cpu-pm=on: to set enable_cpu_pm
> > >  -cpu host: so that cpu->max_features is set
> > > 
> > > For QEMU version, as long as it's after this commit: 662175b91ff2
> > > ("i386: reorder call to cpu_exec_realizefn")
> > > 
> > > The guest fails to boot:
> > > 
> > > [ 24.825568] smpboot: x86: Booting SMP configuration:
> > > [ 24.826377] .... node #0, CPUs: #1 #2 #3 #4 #5 #6 #7 #8 #9 #10 #11 #12
> > > #13 #14 #15 #17
> > > [ 24.985799] .... node #1, CPUs: #128 #129 #130 #131 #132 #133 #134 #135
> > > #136 #137 #138 #139 #140 #141 #142 #143 #145
> > > [ 25.136955] invalid opcode: 0000 1 PREEMPT SMP NOPTI
> > > [ 25.137790] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0 #2
> > > [ 25.137790] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
> > > rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/04
> > > [ 25.137790] RIP: 0010:mwait_idle+0x35/0x80
> > > [ 25.137790] Code: 6f f0 80 48 02 20 48 8b 10 83 e2 08 75 3e 65 48 8b 15
> > > 47 d6 56 6f 48 0f ba e2 27 72 41 31 d2 48 89 d8
> > > [ 25.137790] RSP: 0000:ffffffff91403e70 EFLAGS: 00010046
> > > [ 25.137790] RAX: ffffffff9140a980 RBX: ffffffff9140a980 RCX:
> > > 0000000000000000
> > > [ 25.137790] RDX: 0000000000000000 RSI: ffff97f1ade21b20 RDI:
> > > 0000000000000004
> > > [ 25.137790] RBP: 0000000000000000 R08: 00000005da4709cb R09:
> > > 0000000000000001
> > > [ 25.137790] R10: 0000000000005da4 R11: 0000000000000009 R12:
> > > 0000000000000000
> > > [ 25.137790] R13: ffff98573ff90fc0 R14: ffffffff9140a038 R15:
> > > 0000000000093ff0
> > > [ 25.137790] FS: 0000000000000000(0000) GS:ffff97f1ade00000(0000)
> > > knlGS:0000000000000000
> > > [ 25.137790] CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [ 25.137790] CR2: ffff97d8aa801000 CR3: 00000049e9430001 CR4:
> > > 0000000000770ef0
> > > [ 25.137790] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > > 0000000000000000
> > > [ 25.137790] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7:
> > > 0000000000000400
> > > [ 25.137790] PKRU: 55555554
> > > [ 25.137790] Call Trace:
> > > [ 25.137790] <TASK>
> > > [ 25.137790] ? die+0x37/0x90
> > > [ 25.137790] ? do_trap+0xe3/0x110
> > > [ 25.137790] ? mwait_idle+0x35/0x80
> > > [ 25.137790] ? do_error_trap+0x6a/0x90
> > > [ 25.137790] ? mwait_idle+0x35/0x80
> > > [ 25.137790] ? exc_invalid_op+0x52/0x70
> > > [ 25.137790] ? mwait_idle+0x35/0x80
> > > [ 25.137790] ? asm_exc_invalid_op+0x1a/0x20
> > > [ 25.137790] ? mwait_idle+0x35/0x80
> > > [ 25.137790] default_idle_call+0x30/0x100
> > > [ 25.137790] cpuidle_idle_call+0x12c/0x170
> > > [ 25.137790] ? tsc_verify_tsc_adjust+0x73/0xd0
> > > [ 25.137790] do_idle+0x7f/0xd0
> > > [ 25.137790] cpu_startup_entry+0x29/0x30
> > > [ 25.137790] rest_init+0xcc/0xd0
> > > [ 25.137790] start_kernel+0x396/0x5d0
> > > [ 25.137790] x86_64_start_reservations+0x18/0x30
> > > [ 25.137790] x86_64_start_kernel+0xe7/0xf0
> > > [ 25.137790] common_startup_64+0x13e/0x148
> > > [ 25.137790] </TASK>
> > > [ 25.137790] Modules linked in:
> > > [ 25.137790] --[ end trace 0000000000000000 ]--
> > > [ 25.137790] invalid opcode: 0000 2 PREEMPT SMP NOPTI
> > > [ 25.137790] RIP: 0010:mwait_idle+0x35/0x80
> > > [ 25.137790] Code: 6f f0 80 48 02 20 48 8b 10 83 e2 08 75 3e 65 48 8b 15
> > > 47 d6 56 6f 48 0f ba e2 27 72 41 31 d2 48 89 d8
> > >   
> > > >   
> > > >> following, CPUID_EXT_MONITOR is set after x86_cpu_filter_features(), so
> > > >> that it doesn't have a chance to check MWAIT against host features and
> > > >> will be advertised to the guest regardless of whether it's supported by
> > > >> the host or not.
> > > >>
> > > >> x86_cpu_realizefn()
> > > >>   x86_cpu_filter_features()
> > > >>   cpu_exec_realizefn()
> > > >>     kvm_cpu_realizefn
> > > >>       host_cpu_realizefn
> > > >>         host_cpu_enable_cpu_pm
> > > >>           env->features[FEAT_1_ECX] |= CPUID_EXT_MONITOR;
> > > >>
> > > >>
> > > >> If it's not supported by the host, executing MONITOR or MWAIT
> > > >> instructions from the guest triggers #UD, no matter MWAIT_EXITING
> > > >> control is set or not.  
> > > > 
> > > > If I recall right, kvm was able to emulate mwait/monitor.
> > > > So question is why it leads to exception instead?  
> > > 
> > > KVM can come to play only iff it can trigger MWAIT/MONITOR VM exits. I
> > > didn't find explicit proof from Intel SDM that #UD exceptions take
> > > precedence over MWAIT/MONITOR VM exits, but this is my speculation. For
> > > example, in ancient machines which don't support MWAIT yet, the only way
> > > it can do is #UD, not MWAIT VM exit?  
> > 
> > For the Host which doesn't support MWAIT, it shouldn't have the VMX
> > control bit for mwait exit either, right?
> > 
> > Could you pls check this on your machine? If VMX doesn't support this
> > exit event, then triggering an exception will make sense.
> 
> My assumption (probably wrong) was that KVM would emulate mwait if it's unavailable,


emulating mwait correctly is very hard. KVM does not try.

> unless we have KVM_CAP_X86_DISABLE_EXITS enabled. And in the later case it would
> explode as expected, however then we shouldn't be able to set KVM_CAP_X86_DISABLE_EXITS
> to begin with.
> 
> Recently Sean posted a patch related to that
> [PATCH v2 12/49] KVM: x86: Reject disabling of MWAIT/HLT interception when not allowed
>   https://lkml.org/lkml/2024/5/17/729
> 
> This needs someone with KVM expertise to chime in
> Perhaps Paolo/Sean could clarify expected behavior.
> 
> 
> > 
> > -Zhao
> > 


