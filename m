Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 294D27D3F7E
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 20:47:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quzwT-0006ci-QZ; Mon, 23 Oct 2023 14:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1quzwQ-0006cW-U9
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:46:19 -0400
Received: from skiff.uberspace.de ([185.26.156.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <neither@nut.email>) id 1quzwO-000673-IS
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 14:46:18 -0400
Received: (qmail 14937 invoked by uid 990); 23 Oct 2023 18:46:07 -0000
Authentication-Results: skiff.uberspace.de;
	auth=pass (login)
Date: Mon, 23 Oct 2023 20:45:59 +0200
From: Julian Ganz <neither@nut.email>
To: Alex =?UTF-8?B?QmVubsOpZQ==?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
Subject: Re: [PATCH] tcg-plugins: add a hook for interrupts, exceptions and
 traps
Message-ID: <20231023204506.2670f9e3@neithernut.fritz.box>
In-Reply-To: <87v8ax4fqd.fsf@linaro.org>
References: <20231021122502.26746-1-neither@nut.email>
 <87v8ax4fqd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Bar: +++++
X-Rspamd-Report: SUSPICIOUS_RECIPS(1.5) MIME_GOOD(-0.1) BAYES_SPAM(4.117956)
X-Rspamd-Score: 5.517956
Received: from unknown (HELO unkown) (::1)
 by skiff.uberspace.de (Haraka/3.0.1) with ESMTPSA;
 Mon, 23 Oct 2023 20:46:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nut.email; s=uberspace;
 h=from; bh=gzGHiSB7XZm/NPbhShALUWyEiDRFj6GPy6tsxIURNbg=;
 b=MQNUurQbBakve8g7imSRpgTz2YsqEIcs1HBUUmOUnmIP6cvmcQaN5QXQl+IIrYqsCNP6V6zZZV
 1Ifn1bo/ekx2qx7TTbR6CiyEeqcK9euYjfHmT9JK/tfrUrbDacHqiw3imVIUcWqhVCDnlliu4Uaa
 ekZd8N4iuapDFTzbYOZ4+s2IcvUsFfogr6ryJoDoAimhI+erb0dRzPpQuWRMUBKgsatXSNfRRvnd
 82KBhuVXCQjeJildFYJST426RkQ5FW8vO/MxVtkjM7sdbC2tNrmXKihe5dwiknkwPdrhJywQ/vDx
 FgKdwcxkH32uRw+pdvmGhDG8VSm9rEGaQuHvLA/aK0QxfLkdlx5Z5BENLIBgno/L7/S7BedPZGD6
 77gxxA7yTOgY638MMt8wJSfivobqP8U1r8mwlzS6xIH7CtoOg+elQhcbKmxyRyk1gbk1xWYJhsAw
 8GdvNynQ1fMlTtUNFwq6iSG64PZbP9381jPk1+HWkaST6bpuHnrgoXOFW4rpb1VzijhOBFIvKPM/
 CSphqfy4+EkkZ9BVqdBnQkDdthPSUKrsMl8SzGNhsaqZsJTXxAUklLgUZYi0K8m5DN+CBgX/WmB9
 AcnH4svwE6kp9iIArLUDI/xQCV/6PaLSX9yVePPbZKc2RNwp+mk/ImP3Z+I0Ui9NTeo2DCf2XjRB
 4=
Received-SPF: none client-ip=185.26.156.131; envelope-from=neither@nut.email;
 helo=skiff.uberspace.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Hi all,

thank's for the feedback!

Maybe for broader context: at work a colleague and I are developing a
plugin that implements RISC-V specific tracing [1]. It writes a trace
to a file in the format you'd expect from actual hardware implementing
the relevant interface. Currently, it's developed on top of Xilinx'
qemu-fork with yet another bunch of un-upstreamable patches on top,
some of which introduce some API we use in the plugin. Meaning that if
I open-source the plugin one day, I'll probably need to rewrite parts
of it anyway.


On Mon, 23 Oct 2023 14:08:51 +0100
Alex Benn=C3=A9e <alex.bennee@linaro.org> wrote:
>=20
> Julian Ganz <neither@nut.email> writes:
>=20
> > Some analysis greatly benefits, or depends on, information about
> > interrupts. For example, we may need to handle the execution of a
> > new translation block differently if it is not the result of normal
> > program flow but of an interrupt.
>=20
> I can see the benefit for plugins knowing the context - for QEMU
> itself there is no real difference in how it handles blocks that are
> part of an interrupt.

Yes, that I'm aware of.

> > Even with the existing interfaces, it is more or less possible to
> > discern these situations using some heuristice. For example, the PC
> > landing in a trap vector is a strong indicator that a trap, i.e. an
> > interrupt or event occured. However, such heuristics require
> > knowledge about the architecture and may be prone to errors.
>=20
> Does this requirement go away if you can query the current execution
> state via registers?

So my colleague an I were discussing this again today: knowing the PC,
EPC, ecause (or their equivalent) and the priviledge/mode are not
sufficient since there are too many cases where detecting an exception
(or an interrupt) is non-trivial or impossible. For example, there's no
gurantee that ecause will ever be reset between interrupts and an
exception may occur without a PC discontinuity. Probably the worst case
would be an illegal instruction at the trap handler. But we also found
a few other cases where even if we know excactly which instructions
belonged to an ISR, we could still not tell how we ended up there with
sufficient certainty.

But I'm aware of [2] if that's what you were after, and we do need the
ability to query some registers for our plugin in addition to an
interrupt callback or similar API.


> > --- a/accel/tcg/cpu-exec.c
> > +++ b/accel/tcg/cpu-exec.c
> > @@ -754,6 +754,8 @@ static inline bool
> > cpu_handle_exception(CPUState *cpu, int *ret)
> > qemu_mutex_unlock_iothread(); cpu->exception_index =3D -1;
> > =20
> > +            qemu_plugin_vcpu_interrupt_cb(cpu);
> > +
> >              if (unlikely(cpu->singlestep_enabled)) {
> >                  /*
> >                   * After processing the exception, ensure an
> > EXCP_DEBUG is @@ -866,6 +868,7 @@ static inline bool
> > cpu_handle_interrupt(CPUState *cpu, if
> > (need_replay_interrupt(interrupt_request)) { replay_interrupt();
> >                  }
> > +                qemu_plugin_vcpu_interrupt_cb(cpu);
>=20
> My worry here is:
>=20
>  a) we are conflating QEMU exceptions and interrupts as the same thing
>  b) this is leaking internal implementation details of the translator
>=20
> For example EXCP_SEMIHOST isn't actually an interrupt (we don't change
> processor state or control flow). It's just the internal signalling we
> use to handle our semihosting implementation.

Yes. Funnily enough, that's more or less what we want anyway for our
plugin (because we need to handle `ebreak`s for example). However, in
this specific use-case we need to half-disassemble some instructions
anyway so we would at least have no problem finding and special-casing
`ebreaks`.

But this is indeed likely not what you want for the general case. In
some cases you may still be able to detect the absence of a PC
discontinuity and then just assume that you can ignore an interrupt,
but that would involve logic you normally wouldn't have (e.g. a
callback on individual instructions) and require some knowledge about
the architecture. Which is exctly not what you want for the TCG plugin
API.

> Similarly the CPU_INTERRUPT_EXITTB interrupt isn't really changing
> state, just ensuring we exit the run loop so house keeping is done.

Mh... that one we've not observed yet. Likely because our test-cases
(running OpenSBI with very simple payloads) were too simple.

> The "correct" way for ARM for example would be to register a helper
> function with arm_register_el_change_hook() and trigger the callbacks
> that way. However each architecture does its own IRQ modelling so you
> would need to work out where in the plumbing to do each callback.

I tried to avoid that. But it looks like I don't have a choice :/


> > --- a/include/qemu/qemu-plugin.h
> > +++ b/include/qemu/qemu-plugin.h
> > @@ -206,6 +206,17 @@ void
> > qemu_plugin_register_vcpu_idle_cb(qemu_plugin_id_t id, void
> > qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
> > qemu_plugin_vcpu_simple_cb_t cb);=20
> > +/**
> > + * qemu_plugin_register_vcpu_interrupt_cb() - register a vCPU
> > interrupt callback
> > + * @id: plugin ID
> > + * @cb: callback function
> > + *
> > + * The @cb function is called every time a vCPU receives an
> > interrupt, exception
> > + * or trap.
>=20
> As discussed above you would trigger for a lot more than that. You
> would also miss a lot of the other interesting transitions which
> don't need an asynchronous signal. For example
> HELPER(exception_return) happily changes control flow but doesn't
> need to use the exception mechanism to do it.

Huh. I wasn't aware of that.


> I'm not opposed to adding such a API hook to plugins but I don't think
> the current approach does what you want. If we do add a new API it is
> customary to either expand an existing plugin or add a new one to
> demonstrate the use of the API.

After receiving your feedback I agree that I was maybe a bit too eager.
I'll return to the drawing board and prepare a new series with a simple
demonstrator (maybe a simple interrupt-counter and/or plugin meassuring
the "time" spent in an inteerupt). But since I'm not too intimate with
qemu internals, this will likely take some time.

Kind regards,
Julian

[1] https://github.com/riscv-non-isa/riscv-trace-spec
[2] https://gitlab.com/qemu-project/qemu/-/issues/1706

